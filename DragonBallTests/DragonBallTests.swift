
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


//I had to do some research to test the login because it seemed complicated to me, but at least now I know how to test it.
final class LoginAuthenticate: XCTestCase {
    
    var sut: NetworkModel!
    
    override func setUp() {
        super.setUp()
        
        sut = NetworkModel.shared
    }

    func testLoginSuccess() {
        
        //Give
        let validUsername = "s@gmail.com"
        let validPassword = "Regularuser1"
        
        //When
        sut.login(user: validUsername, password: validPassword) { result in
            switch result {
            case .success(let jwtToken):
        
        //Assert
                XCTAssertFalse(jwtToken.isEmpty) //Check that it is not empty
                XCTAssertEqual(jwtToken,"eyJraWQiOiJwcml2YXRlIiwiYWxnIjoiSFMyNTYiLCJ0eXAiOiJKV1QifQ.eyJleHBpcmF0aW9uIjo2NDA5MjIxMTIwMCwiaWRlbnRpZnkiOiJDMzk0Mzc1NC04MUJCLTRDM0MtOTU3RS04MTcyOTQxOTQyQTEiLCJlbWFpbCI6InNAZ21haWwuY29tIn0.OHi5V6kGXtNaXR24VUFkkqTkoTwry7GZJaJNGhefee4")  // Check that the token is the expected one received.
            case .failure(let error):
                XCTFail("Login failed with error: \(error)") // Report an error if it fails.
            }
          
        }
        

    }
    
}
