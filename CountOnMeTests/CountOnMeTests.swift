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
    func testGivenRandomNunbers_WhenAddMulDivide_ThenGoodResult() {
        let operand1 = Double.random(in: 0...1000)
        let operand2 = Double.random(in: 0...10000)
        let operand3 = Double.random(in: 1000...100000)
        let newCalcul = Calculation(elements: ["\(operand1)","x","\(operand2)","÷","\(operand3)"])
        let calcul = newCalcul.calculateState()
        let expectedResult = (operand1 * operand2) / operand3
        XCTAssertEqual(calcul, ["\(expectedResult)"])
    }
    func testGivenExpression_WhenTheExpressionEndsWithAnOperand_ThenExpressionIsCorrectEqualFalse() {
        let newCalcul = Calculation(elements: ["10","-","2","+"])
        XCTAssertEqual(false, newCalcul.expressionIsCorrect)
    }
    func testGivenExpression_WhenTheExpressionDosentEndsWithAnOperand_ThenExpressionIsCorrectEqualTrue() {
        let newCalcul = Calculation(elements: ["10","-","2"])
        XCTAssertEqual(true, newCalcul.expressionIsCorrect)
    }
    func testGivenExpression_WhenDivisionBy0_ThenIsCalculableEqualFalse() {
        let newCalcul = Calculation(elements: ["10","-","2","÷","0"])
        XCTAssertEqual(false, newCalcul.isCalculable)
    }
    func testGivenExpression_WhenThisExpressionCalculable_ThenIsCalculableEqualFalse() {
        let newCalcul = Calculation(elements: ["10","-","2","+","0"])
        XCTAssertEqual(true, newCalcul.isCalculable)
    }
    func testGivenExpression_WhenThisExpressionDoesNotHaveEnoughElement_ThenThisExpressionHaveEnoughElementEqualFalse() {
        let newCalcul = Calculation(elements: ["10","-"])
        XCTAssertEqual(false, newCalcul.expressionHaveEnoughElement)
    }
    func testGivenExpression_WhenThisExpressionHaveEnoughElement_ThenThisExpressionHaveEnoughElementEqualTrue() {
        let newCalcul = Calculation(elements: ["10","-","2","÷","0"])
        XCTAssertEqual(true, newCalcul.expressionHaveEnoughElement)
    }
    func testGivenExpression_WhenThisExpressionHaveComputepriority_ThenGoodResult() {
        let operand1 = Double.random(in: 0...1000)
        let operand2 = Double.random(in: 0...10000)
        let operand3 = Double.random(in: 1000...100000)
        let operand4 = Double.random(in: 230...10090000)
        let operand5 = Double.random(in: 450...10008930)
        let operand6 = Double.random(in: 103900...100089300)
        let newCalcul = Calculation(elements: ["\(operand1)","x","\(operand2)","÷","\(operand3)","+","\(operand4)","-","\(operand5)","x","\(operand6)"])
        let goodResult = operand1 * operand2 / operand3 + operand4 - operand5 * operand6
        XCTAssertEqual(true, newCalcul.expressionIsCorrect)
        XCTAssertEqual(true, newCalcul.isCalculable)
        XCTAssertEqual(true, newCalcul.expressionHaveEnoughElement)
        XCTAssertEqual(["\(goodResult)"], newCalcul.calculateState())
        
    }
    func testGivrnExpression_WhenDivideByALargerNumber_ThenDoesNotEraseThe0AndTheComma()  {
        let newCalcul = Calculation(elements: ["15800000658","÷","45889855052089"])
        XCTAssertEqual(newCalcul.calculateState(), ["0.00034430269261181187"])
    }
}
