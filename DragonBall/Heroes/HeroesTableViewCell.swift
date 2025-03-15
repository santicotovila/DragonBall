//
//  HeroesTableViewCell.swift
//  DragonBall
//
//  Created by Santiago Coto Vila on 11/03/2025.
//

import UIKit

final class HeroesTableViewCell: UITableViewCell {

    static let identifierCell = String(describing: HeroesTableViewCell.self)
//MARK: - Outlets
    
    @IBOutlet var nameHero: UILabel!
    
    @IBOutlet var infoHero: UILabel!
    
    @IBOutlet var imageHero: UIImageView!
    


    
    func configure(with hero: Hero) {
        nameHero.text = hero.name
        nameHero.font = UIFont.boldSystemFont(ofSize: 18)
        infoHero.text = hero.description
        infoHero.font = UIFont.italicSystemFont(ofSize: 15)
        imageHero.loadImage(from: hero.photo)
        
        
    }
    
    
}
