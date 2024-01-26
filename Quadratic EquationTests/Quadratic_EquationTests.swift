//
//  Quadratic_EquationTests.swift
//  Quadratic EquationTests
//
//  Created by Phys440Zachary on 1/19/24.
//

import XCTest

final class Quadratic_EquationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testNormal() async {
        let myQuadCalc = Quadratic_Calculator()
        
        let testa = 1.0
        let testb = 1.0
        let testc = 0.0001
        
        let normalSols = await myQuadCalc.calculateNormal(ain: testa, bin: testb, cin: testc)

        XCTAssertEqual(normalSols.PositiveValue, -1.0001E-4, accuracy:1.0E-7, "Was not equal to this resolution.")
        XCTAssertEqual(normalSols.NegativeValue, -0.9998, accuracy:1.0E-4, "Was not equal to this resolution.")
    }
    func testAbnormal() async {
        let myQuadCalc = Quadratic_Calculator()
        
        let testa = 1.0
        let testb = 1.0
        let testc = 0.0001
        
        let abnormalSols = await myQuadCalc.calculateAbnormal(ain: testa, bin: testb, cin: testc)

        XCTAssertEqual(abnormalSols.PositiveValue, -1.0001E-4, accuracy:1.0E-7, "Was not equal to this resolution.")
        XCTAssertEqual(abnormalSols.NegativeValue, -0.9998, accuracy:1.0E-4, "Was not equal to this resolution.")
    }
    func testEqual() async {
        let myQuadCalc = Quadratic_Calculator()
        
        let testa = 1.0
        let testb = 1.0
        let testc = 0.000000000001
        
        let normalSols = await myQuadCalc.calculateNormal(ain: testa, bin: testb, cin: testc)
        let abnormalSols = await myQuadCalc.calculateAbnormal(ain: testa, bin: testb, cin: testc)
        
        XCTAssertEqual(abnormalSols.PositiveValue, normalSols.PositiveValue, accuracy:1.0E-7, "Was not equal to this resolution.")
        XCTAssertEqual(abnormalSols.NegativeValue, normalSols.NegativeValue, accuracy:1.0E-7, "Was not equal to this resolution.")
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
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
