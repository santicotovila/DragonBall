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
        sut = Hero(id: "some_id",
                   photo: "",
                   favorite: false,
                   name: name,
                   description: "some-description")
        //Then// Assert
        XCTAssertEqual(sut.name, name)
        
    }
    
    
    
    /*    override func setUpWithError() throws {
     // Put setup code here. This method is called before the invocation of each test method in the class.
     }
     
     override func tearDownWithError() throws {
     // Put teardown code here. This method is called after the invocation of each test method in the class.
     }
     
     func testExample() throws {
     // This is an example of a functional test case.
     // Use XCTAssert and related functions to verify your tests produce the correct results.
     // Any test you write for XCTest can be annotated as throws and async.
     // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
     // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
     }
     
     func testPerformanceExample() throws {
     // This is an example of a performance test case.
     self.measure {
     // Put the code you want to measure the time of here.
     }
     }
     
     }
     */
}
