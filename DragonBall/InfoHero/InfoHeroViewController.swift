//
//  InfoHeroViewController.swift
//  DragonBall
//
//  Created by Santiago Coto Vila on 12/03/2025.
//

import UIKit

enum InfoHeros {
    case Hero
}


final class InfoHeroViewController: UIViewController {
    
    static let identifierInfo = String(describing: InfoHeroViewController.self)
    //MARK: - Outlets
    
    @IBOutlet var ImageHero: UIImageView!
    
    @IBOutlet var nameHero: UILabel!
    
    @IBOutlet var descriptionHero: UILabel!
 
    
    @IBAction func Transformations() {
        guard let hero = hero else { return }
        let transformationsVC = TransformationsCollectionViewController(hero: hero)
        navigationController?.show(transformationsVC, sender: self)
       
    }

    

    
    var hero: Hero?
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Desempaqueto porque es optional
        guard let hero = hero else { return }
        configure(with: hero)
        
    }
    
  
    
    func configure(with hero: Hero) {
        
        ImageHero.loadImage(from: hero.photo)
        nameHero.text = hero.name
        nameHero.font = UIFont.boldSystemFont(ofSize: 20)
        descriptionHero.text = hero.description
        descriptionHero.font = UIFont.italicSystemFont(ofSize: 15)
        
    }


    
}


 


