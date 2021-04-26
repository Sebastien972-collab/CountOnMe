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
    let newCalcul = Calculation()
    private func setResult(element : String) -> [String] {
        newCalcul.setExpression(elements: element)
        return newCalcul.calculateState()
    }
    func testGiven5_WhenWeMultiplyFor2_Then10() {
        newCalcul.setExpression(elements: "5 x 2")
        let calcul = newCalcul.calculateState()
        XCTAssert(calcul ==  ["10"])
    }
    
    func testGiven10_WhenWeDivideFor2_Then5() {
        XCTAssert(setResult(element: "10 ÷ 2") == ["5"])
    }
    func testGiven5_WhenWeAddFor2_Then7() {
        
        XCTAssert(setResult(element: "5 + 2") ==  ["7"])
    }
    func testGiven10_WhenWeAddFor2_Then8() {
        XCTAssert(setResult(element: "10 - 2") == ["8"])
    }
    func testGivenRandomNunbers_WhenAddMulDivide_ThenGoodResult() {
        let operand1 = Double.random(in: 0...1000)
        let operand2 = Double.random(in: 0...10000)
        let operand3 = Double.random(in: 1000...100000)
        let expectedResult = (operand1 * operand2) / operand3
        XCTAssertEqual(setResult(element: "\(operand1) x \(operand2) ÷ \(operand3)"), ["\(expectedResult)"])
    }
    func testGivenExpression_WhenTheExpressionEndsWithAnOperand_ThenExpressionIsCorrectEqualFalse() {
        newCalcul.setExpression(elements: "10 - 2 +")
        XCTAssertEqual(false,newCalcul.expressionIsCorrect)
    }
    func testGivenExpression_WhenTheExpressionDosentEndsWithAnOperand_ThenExpressionIsCorrectEqualTrue() {
        newCalcul.setExpression(elements: "10 - 2")
        XCTAssertEqual(true, newCalcul.expressionIsCorrect)
    }
    func testGivenExpression_WhenDivisionBy0_ThenIsCalculableEqualFalse() {
        newCalcul.setExpression(elements: "10 - 2 ÷ 0")
        XCTAssertEqual(false, newCalcul.isCalculable)
    }
    func testGivenExpression_WhenThisExpressionCalculable_ThenIsCalculableEqualFalse() {
        newCalcul.setExpression(elements: "10 - 2 + 0")
        XCTAssertEqual(true, newCalcul.isCalculable)
    }
    func testGivenExpression_WhenThisExpressionDoesNotHaveEnoughElement_ThenThisExpressionHaveEnoughElementEqualFalse() {
        newCalcul.setExpression(elements: "10 -")
        XCTAssertEqual(false, newCalcul.expressionHaveEnoughElement)
    }
    func testGivenExpression_WhenThisExpressionHaveEnoughElement_ThenThisExpressionHaveEnoughElementEqualTrue() {
        newCalcul.setExpression(elements:  "10 - 2 ÷ 0")
        XCTAssertEqual(true, newCalcul.expressionHaveEnoughElement)
    }
    func testGivenExpression_WhenThisExpressionHaveComputepriority_ThenGoodResult() {
        let operand1 = Double.random(in: 0...1000)
        let operand2 = Double.random(in: 0...10000)
        let operand3 = Double.random(in: 1000...100000)
        let operand4 = Double.random(in: 230...10090000)
        let operand5 = Double.random(in: 450...10008930)
        let operand6 = Double.random(in: 103900...100089300)
        newCalcul.setExpression(elements: "\(operand1) x \(operand2) ÷ \(operand3) + \(operand4) - \(operand5) x \(operand6)")
        let goodResult = operand1 * operand2 / operand3 + operand4 - operand5 * operand6
        XCTAssertEqual(true, newCalcul.expressionIsCorrect)
        XCTAssertEqual(true, newCalcul.isCalculable)
        XCTAssertEqual(true, newCalcul.expressionHaveEnoughElement)
        XCTAssertEqual(["\(goodResult)"], newCalcul.calculateState())
        
    }
    func testGivenExpression_WhenDivideByALargerNumber_ThenDoesNotEraseThe0AndTheComma()  {
        newCalcul.setExpression(elements: "15800000658 ÷ 45889855052089")
        XCTAssertEqual(newCalcul.calculateState(), ["0.00034430269261181187"])
    }
    func testGivenANumber_WhenSusbtractByTheSameNumber_ThenEqual0Not0Comma0() {
        newCalcul.setExpression(elements: "9 - 9")
        XCTAssertEqual(newCalcul.calculateState(), ["0"])
    }
    func testGivenAExpression_WhenWeCantAddOperand_ThenCanAddOperatorFalse() {
        newCalcul.setExpression(elements: "2 + 3 -")
        XCTAssertEqual(false, newCalcul.canAddOperator)
    }
    func testGivenAExpression_WhenWeCanAddOperand_ThenCanAddOperatorTrue() {
        newCalcul.setExpression(elements: "2 + 3 - 9")
        XCTAssertEqual(true, newCalcul.canAddOperator)
    }
    func testGivenAExpression_WhenWeHaveResult_TheHaveResultEqualTrue() {
        newCalcul.setExpression(elements: "2 + 3 = 9")
        XCTAssertEqual(true, newCalcul.haveResult)
    }
    func testGivenAExpression_WhenWeDontHaveResult_TheHaveResultEqualFalse() {
        newCalcul.setExpression(elements: "2 + 3 + 9")
        XCTAssertEqual(false, newCalcul.haveResult)
    }
}
