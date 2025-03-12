import UIKit

extension UIImageView {
    func setImage(url: URL) {
        dowloadWithUrlSession(url: url) {[weak self] result in
            switch result {
            case let .success(image):
                DispatchQueue.main.async {
                    self?.image = image
                }
            case .failure:
                break
                
            }
            
        }
    }
    private func dowloadWithUrlSession(url: URL,
                                       completion: @escaping (Result<UIImage,Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data,
                  let image = UIImage(data: data) else{
                completion(.failure(NSError(domain: "Image Dowloand Error", code: 0)))
                return
            }
            completion(.success(image))
        }
        .resume()
        
    }
}

///FIXME🛠️🛠️🛠️
///if let imageUrl = URL(string: "https://ejemplo.com/imagen.jpg") {
///imageView.setImage(url: imageUrl)
///}

