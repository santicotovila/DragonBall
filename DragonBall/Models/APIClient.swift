import Foundation


enum APIClientError: Error, Equatable{
    case malformedURL
    case noData
    case StatusCode(code:Int?)
    case decodingFailed
    case unknown
}

// 1. Primer paso para controlar una dependencia. Empaquetarla en un protocolo

protocol APIClientProtocol {
    
    func jwt(_ request: URLRequest, completion: @escaping (Result<String,APIClientError>) -> Void)
    func request <T: Decodable>(_ request: URLRequest, using: T.Type, completion: @escaping (Result<T, APIClientError>) -> Void)
}

struct APIClient: APIClientProtocol {
    
    static let shared = APIClient()
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    // Con este método vamos a obtener el JWT de la API
    
    func jwt(_ request: URLRequest, completion: @escaping (Result<String,APIClientError>) -> Void)
    {
        let task = session.dataTask(with: request) { data, response, error in
            // Compruebo si hay un error
            guard  error ==  nil else {
                // Si el error existe,lo envio al completion
                if let error = error as?  NSError {
                    completion(.failure(.StatusCode(code: error.code)))
                } else {
                    completion(.failure(.unknown))
                }
                return
            }
            // Compruebo si hay data
            guard let data else {
                // Si no hay data,envio el error '.noData'
                completion(.failure(.noData))
                return
            }
            let response = (response as? HTTPURLResponse)
            
            // Compruebo si la respuesta es satisfactoria
            
            guard let response, response.statusCode == 200 else {
                completion(.failure(.StatusCode(code: response?.statusCode)))
                return
            }
            guard let jwt = String.init(data: data, encoding: .utf8) else {
                completion(.failure(.decodingFailed))
                return
            }
            completion(.success(jwt))
        }
        // Con esto podemos ejecutar la tarea.
        task.resume()
    }
    
    // Lo usaremos con Hero y con Transformation
    // Para este metodo request, T va a ser Decodable
    // Para el parametro using, T.Type,sera tanto Hero como Tranformation
    // Esto lo podemos usar para otras cosas porque es generico
    
    func request <T: Decodable>(_ request: URLRequest, using: T.Type, completion: @escaping (Result<T, APIClientError>) -> Void)  {
        
        let task = session.dataTask(with: request) { data, response , error in
            guard error == nil else {
                if let error = error as? NSError {
                    completion(.failure(.StatusCode(code: error.code)))
                } else {
                    completion(.failure(.unknown))
                               
                }
                return
                
            }
            guard let data else {
                completion(.failure(.noData))
                return
            }
            let response = response as? HTTPURLResponse
            
            guard let response,response .statusCode == 200 else {
                completion(.failure(.StatusCode(code: response?.statusCode)))
                return
            }
            // Hago el try porque es throw
            guard let decodedModel = try? JSONDecoder().decode(using, from: data) else {
                completion(.failure(.decodingFailed))
                return
            }
            completion(.success(decodedModel))
        }
        task.resume()
    }
}
