//
//  NetworkModelTests.swift
//  DragonBallTests
//
//  Created by Santiago Coto Vila on 08/03/2025.
//

import XCTest
@testable import DragonBall

final class NetworkModelTests: XCTestCase {

    private var sut: NetworkModel!
    private var apiClient: APIClientMock!
    
    
    override func setUp() {
        super.setUp()
        apiClient = APIClientMock()
        sut = NetworkModel(client: apiClient)
        sut.token = "some-token"
    }
    
    func test_getHeroes_emptyHeros_success() {
        //Given
        
        let successResult = Result <[Hero], APIClientError>.success([])
        apiClient.receivedHeroResult = successResult
        
        
        //When
        
        var receivedHeroes: Result<[Hero], APIClientError>?
        sut.getHeros { result in
            receivedHeroes = result
        }
        // Then
        XCTAssertEqual(successResult,receivedHeroes)
        XCTAssertEqual(apiClient.receivedRequest?.url, URL(string: "dragonball.keepcoding.education/api/all"))
        let authorizationHeaderValue = apiClient.receivedRequest?.allHTTPHeaderFields?["Authorization"]
        XCTAssertEqual(authorizationHeaderValue, "Bearer some-token")
    }


}
