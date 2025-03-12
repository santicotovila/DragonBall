//
//  HeroesTableViewController.swift
//  DragonBall
//
//  Created by Santiago Coto Vila on 11/03/2025.
//

import UIKit

enum HeroesSection {
    case Heroes
}

final class HeroesTableViewController: UITableViewController {
    
    static let identifierTable = String(describing: HeroesTableViewController.self)
    
    //MARK: - Table View DataSource
    
    typealias DataSource = UITableViewDiffableDataSource<HeroesSection, Hero>
    typealias SnapShot = NSDiffableDataSourceSnapshot<HeroesSection, Hero>
    
    private var dataSource: DataSource?
    private var heroes: [Hero] = [] // Almacenar los héroes aquí
    

    let networkmodel = NetworkModel(client: APIClient.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHeros()
        
        
        // Registrar la celda en la tabla
        tableView.register(
            UINib(nibName: HeroesTableViewCell.identifierCell, bundle: nil),
            forCellReuseIdentifier: HeroesTableViewCell.identifierCell
        )
       
        
        // Configurar el dataSource
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
        
        var snapshot = SnapShot()
        snapshot.appendSections([.Heroes])
        snapshot.appendItems(heroes)
        dataSource?.apply(snapshot)
        

        
    }
    
private func getHeros() {
    let networkModel = NetworkModel.shared
    
    networkModel.getHeros { [weak self] result  in
        
        // Desempaqueto porque al tener que evitar el ciclo de retencion necesito hacer self opcional.
      guard let self = self else { return }
        
        switch result {
        case let .success(resultHeroes):
            
            DispatchQueue.main.async {
                self.heroes = resultHeroes
                
                var snapshot = SnapShot()
                snapshot.appendSections([.Heroes])
                snapshot.appendItems(self.heroes)
                self.dataSource?.apply(snapshot)
                print("Obteidos")
                
            //    let infoHero = InfoHeroViewController()
             //   self?.navigationController?.
                
            }
        case let.failure(error):
            print(error)
        }
    }
    
    
    }

    


    
}

extension HeroesTableViewController {
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        250
    }
}
