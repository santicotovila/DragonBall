//
//  DragonBallTests.swift
//  DragonBallTests
//
//  Created by Santiago Coto Vila on 06/03/2025.
//

import XCTest
@testable import DragonBall

final class HeroTests: XCTestCase {
    private var sut: Hero!
    
    func test_init_withName_isGoku() {
        
        //Given
        let name = "Goku"
        //When
        sut = Hero(id: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94",
                   favorite: false,
                   name: name,
                   description: "",
                   photo: "")
                   
                   
                   
        //Then// Assert
        XCTAssertEqual(sut.name, name)
        
        
    }
}

final class TransformationTest: XCTestCase {
    private var sut: Transformation!
    
    func test_init_withTransformation_isSuperSaiyan() {
        
        //Give
        let name = "Super Saiyan"
        
        // When
        
        sut = Transformation(name: name,
                             id: "",
                             photo: "",
                             description: "")
        
        //Assert
        
        XCTAssertEqual(sut.name, name)
    }
}

final class LoginAuthenticate: XCTestCase {
    
    var sut: NetworkModel!
    
    override func setUp() {
        super.setUp()
        // Iniciamos el objeto NetworkModel que va a usar el APIClient real
        sut = NetworkModel.shared
    }

    func testLoginSuccess() {
        
        let validUsername = "s@gmail.com"
        let validPassword = "Regularuser1"
        
        sut.login(user: validUsername, password: validPassword) { result in
            switch result {
            case .success(let jwtToken):
                
                XCTAssertFalse(jwtToken.isEmpty)
                XCTAssertEqual(jwtToken,"eyJraWQiOiJwcml2YXRlIiwiYWxnIjoiSFMyNTYiLCJ0eXAiOiJKV1QifQ.eyJleHBpcmF0aW9uIjo2NDA5MjIxMTIwMCwiaWRlbnRpZnkiOiJDMzk0Mzc1NC04MUJCLTRDM0MtOTU3RS04MTcyOTQxOTQyQTEiLCJlbWFpbCI6InNAZ21haWwuY29tIn0.OHi5V6kGXtNaXR24VUFkkqTkoTwry7GZJaJNGhefee4")
            case .failure(let error):
                XCTFail("Login failed with error: \(error)")
            }
          
        }
        

    }
    
}
