import UIKit

// Refactor of funcion to use it to receive strings or URLs
extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        loadImage(from: url)
    }

    func loadImage(from url: URL) {
        downloadImage(with: url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.image = image
                }
            case .failure:
                break
            }
        }
    }

    private func downloadImage(with url: URL,
                               completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "Image Download Error", code: 0)))
                return
            }
            completion(.success(image))
        }.resume()
    }
}
