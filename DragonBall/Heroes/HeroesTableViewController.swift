
import UIKit

// Enum created to make the application scalable
enum HeroesSection {
    case Heroes
}
// Create tableView
final class HeroesTableViewController: UITableViewController {
    
    static let identifierTable = String(describing: HeroesTableViewController.self)
    
    //MARK: - Table View DataSource
    
    typealias DataSource = UITableViewDiffableDataSource<HeroesSection, Hero>
    typealias SnapShot = NSDiffableDataSourceSnapshot<HeroesSection, Hero>
    
    private var dataSource: DataSource?
    private var heroes: [Hero] = [] // Save heros here.
    

    let networkmodel = NetworkModel(client: APIClient.shared)
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Call Heros and configure background tableView.
        tableView.backgroundColor = .systemGray
        getHeros()
        
        
        // Register the cell reusable in tableView
        
        tableView.register(
            UINib(nibName: HeroesTableViewCell.identifierCell, bundle: nil),
            forCellReuseIdentifier: HeroesTableViewCell.identifierCell
        )
       
        
        // Configure dataSource
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, hero in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HeroesTableViewCell.identifierCell,
                for: indexPath
            ) as? HeroesTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: hero)
            return cell
        }
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        //  Apply a dataSource Heros.
        var snapshot = SnapShot()
        snapshot.appendSections([.Heroes])
        snapshot.appendItems(heroes)
        dataSource?.apply(snapshot)
        

        
    }
    
    // Get heros for tableView
    
private func getHeros() {
    let networkModel = NetworkModel.shared
    
    // Avoid cycle retention
    
    networkModel.getHeros { [weak self] result  in
  
      guard let self = self else { return }
        
        switch result {
        case let .success(resultHeroes):
            
            // Main thread
            DispatchQueue.main.async {
                self.heroes = resultHeroes
                
                var snapshot = SnapShot()
                snapshot.appendSections([.Heroes])
                snapshot.appendItems(self.heroes)
                self.dataSource?.apply(snapshot)
                
            }
        case let.failure(error):
            print(error)
        }
    }
    
    }

}

// Configuration cells.
extension HeroesTableViewController {
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        120
    }
    
    
    //Select what we want to display in the row and use show to navigate to the next view.
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let heroViewController = InfoHeroViewController(nibName: InfoHeroViewController.identifierInfo, bundle: nil)
        
        heroViewController.hero = self.heroes[indexPath.row]
        
        
        self.navigationController?.show(heroViewController, sender: self)
    }
}

