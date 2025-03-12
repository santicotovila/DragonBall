import Foundation
@testable import DragonBall

final class APIClientMock: APIClientProtocol {
    
    var didCallJWT = false
    var receivedTokenRequest: URLRequest?
    var receivedTokenResult: Result<String, APIClientError>?
    
    func jwt(_ request: URLRequest, completion: @escaping (Result<String, DragonBall.APIClientError>) -> Void) {
        
        didCallJWT = true
        receivedRequest = request
        
        if let result = receivedTokenResult{
            completion(result)
        }
    }
    
    var didCallRequest = false
    var receivedRequest: URLRequest?
    var receivedHeroResult: Result<[Hero], APIClientError>?
    var receivedTranformationResut: Result<[Transformation], APIClientError>?
    
    func request<T>(_ request: URLRequest, using: T.Type, completion: @escaping (Result<T, DragonBall.APIClientError>) -> Void) where T : Decodable {
        
        didCallRequest = true
        receivedRequest = request
        if let heroResult = receivedHeroResult as? Result<T, APIClientError>{
            completion(heroResult)
            return
        }
        if let transformationResult = receivedTranformationResut as? Result<T, APIClientError>{
            
            completion(transformationResult)
            return
        }
    }
    
}
