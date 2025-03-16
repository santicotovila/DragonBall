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
    
    func test_getHeroes_emptyHeroes_success() {
        // Given
        let successResult = Result<[Hero], APIClientError>.success([])
        apiClient.receivedHeroResult = successResult
        
        // When
        var receivedResult: Result<[Hero], APIClientError>?
        sut.getHeros { result in
            receivedResult = result
        }
        
        // Then
        XCTAssertEqual(successResult, receivedResult)
        XCTAssertEqual(
            apiClient.receivedRequest?.url,
            URL(string: "https://dragonball.keepcoding.education/api/heros/all")
        )
        let authorizationHeaderValue = apiClient.receivedRequest?.allHTTPHeaderFields?["Authorization"]
        XCTAssertEqual(authorizationHeaderValue, "Bearer some-token")
    }
}
