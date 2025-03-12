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
        nameHero.font = UIFont.boldSystemFont(ofSize: 26)
        infoHero.text = hero.description
        infoHero.font = UIFont.italicSystemFont(ofSize: 18)
        imageHero.loadImage(from: hero.photo)
        
        
    }
    
    
}

// Cree la extension para acceder a la imagen ya que recibo un string de la url pero si quiero cargara tengo que convertirla a UIimage

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
