
import UIKit

// enum to make app scalable
enum TransformationsSection {
    case transformations
}

protocol LayoutDelegate {
    func createSizeForItem() -> CGSize
}

final class TransformationsCollectionViewController: UICollectionViewController {

    
    // MARK: - Initializer
    init(hero:Hero) {
        self.hero = hero
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Creating typealiases to shorten calls to the DataSource and Snapshot
    
    typealias DataSource = UICollectionViewDiffableDataSource<TransformationsSection, Transformation>
    typealias SnapShot = NSDiffableDataSourceSnapshot<TransformationsSection, Transformation>
    
    //MARK: - Data
    private var transformations: [Transformation] = []
    private var dataSource: DataSource?
    private var hero: Hero
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .lightGray
        
        //Register cell in CollectionView
        
        let registration = UICollectionView.CellRegistration<TransformationsCollectionViewCell, Transformation>(
            cellNib: UINib(nibName: TransformationsCollectionViewCell.identifier, bundle: nil)) {
                cell, indexPath, transformation in
                cell.configure(with: transformation)
        }
        
        //Configure cell reusable.
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, transformation in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: transformation)
        }
        
        collectionView.dataSource = dataSource
        
        //Call to transformations
        getTransformations()
        
        var snapshot = SnapShot()
        snapshot.appendSections([.transformations])
        snapshot.appendItems(transformations, toSection: .transformations)
        dataSource?.apply(snapshot)
        

        
    }
    
    private func getTransformations() {
        let networkModel = NetworkModel.shared
        
        networkModel.getTransformations(for: hero) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(resultTransformations):
                DispatchQueue.main.async {
                    self.transformations = resultTransformations // Update array with new data
                    
                    var snapshot = SnapShot()
                    snapshot.appendSections([.transformations])
                    snapshot.appendItems(resultTransformations, toSection: .transformations)
                    self.dataSource?.apply(snapshot)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}


// Implementing UICollectionViewDelegateFlowLayout in the cell and structure the desired size.
extension TransformationsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let columnNumber: CGFloat = 2
        let width = (collectionView.frame.size.width - 32) / columnNumber
        return CGSize(width: width, height: 200)
    }
    
    
}

