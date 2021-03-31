//
//  SimpleCalcUITests.swift
//  SimpleCalcUITests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {

    override func setUp() {
    }
    
    func testGiven5_WhenWeMultiplyFor2_Then10() {
        let newCalcul = Calculation(left: 5, operand: "x", right: 2)
        let calcul5 = newCalcul.calculate()
        
        XCTAssert(calcul5 ==  10)
    }
    func testGiven10_WhenWeDivideFor2_Then5() {
        let newCalcul = Calculation(left: 10, operand: "÷", right: 2)
        let calcul5 = newCalcul.calculate()
        
        XCTAssert(calcul5 ==  5)
    }
    func testGiven5_WhenWeAddFor2_Then7() {
        let newCalcul = Calculation(left: 5, operand: "+", right: 2)
        let calcul5 = newCalcul.calculate()
        
        XCTAssert(calcul5 ==  7)
    }
}
