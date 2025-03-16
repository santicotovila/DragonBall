//
//  TransformationsCollectionViewController.swift
//  DragonBall
//
//  Created by Santiago Coto Vila on 14/03/2025.
//

import UIKit

// Creo el enum para hacerlo escalable.
enum TransformationsSection {
    case transformations
}

// Protocolo  fuera de la clase
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
        
        let registration = UICollectionView.CellRegistration<TransformationsCollectionViewCell, Transformation>(
            cellNib: UINib(nibName: TransformationsCollectionViewCell.identifier, bundle: nil)) {
                cell, indexPath, transformation in
                cell.configure(with: transformation)
        }
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, transformation in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: transformation)
        }
        
        collectionView.dataSource = dataSource
        
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
                    self.transformations = resultTransformations // Actualiza el array con los nuevos datos
                    
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


// Implementación de UICollectionViewDelegateFlowLayout en la celda
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
/*final class LayoutDelegator {
    var delegate: LayoutDelegate?
    
    func configureCell() -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        guard let size = delegate?.createSizeForItem() else {
            return cell
        }
        // Añado el tamaño a la celda
        cell.sizeThatFits(size)
        return cell
    }
}
*/

