//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by DAGUIN Sébastien on 28/02/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {

    func testGiven5_WhenWeMultiplyFor2_Then10() {
        let newCalcul = Calculation(elements: ["5","x","2"])
        let calcul5 = newCalcul.calculateState()
        
        XCTAssert(calcul5 ==  ["10"])
    }
    func testGiven10_WhenWeDivideFor2_Then5() {
        let newCalcul = Calculation(elements: ["10","÷","2"])
        let calcul5 = newCalcul.calculateState()
        
        XCTAssert(calcul5 == ["5"])
    }
    func testGiven5_WhenWeAddFor2_Then7() {
        let newCalcul = Calculation(elements: ["5","+","2"])
        let calcul5 = newCalcul.calculateState()
        
        XCTAssert(calcul5 ==  ["7"])
    }
    func testGiven10_WhenWeAddFor2_Then8() {
        let newCalcul = Calculation(elements: ["10","-","2"])
        let calcul5 = newCalcul.calculateState()
        
        XCTAssert(calcul5 == ["8"])
    }
}
