import UIKit

// Create enum to scalable.
enum InfoHeros {
    case Hero
}

// Configure ViewController
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
    
    //MARK: - Life cycle
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Unwrap becouse is optional.
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


 


