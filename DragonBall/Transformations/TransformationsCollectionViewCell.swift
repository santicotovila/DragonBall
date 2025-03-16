
import UIKit


final class TransformationsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: TransformationsCollectionViewCell.self)
    
    //MARK: - Outlets
    
    @IBOutlet var ImageTransformation: UIImageView!

    @IBOutlet var Transformation: UILabel!
    
    
    //MARK: - Configuration
    
    func configure(with transformation: Transformation) {
        ImageTransformation.loadImage(from: transformation.photo)
        Transformation.text = transformation.name
        
            
    }


    

}
