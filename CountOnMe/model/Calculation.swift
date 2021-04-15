//
//  Calculation.swift
//  CountOnMe
//
//  Created by DAGUIN Sébastien on 26/02/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

class Calculation {
    /// Get the expression
    private var elements : [String] = []
    /// Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" && !elements.isEmpty
    }
    ///Check if expression have enough element
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    /// Check if expression is calculable
    var isCalculable : Bool {
        for (index, _) in elements.enumerated() {
            if elements[index] == "÷" && elements[index + 1] == "0" || elements.isEmpty {
                return false
            }
        }
        return true
    }
    var canAddOperator: Bool {
        return expressionIsCorrect
    }
    func setExpression(elements : String) {
        if !elements.isEmpty {
            self.elements = elements.split(separator: " ").map { "\($0)" }
        }
    }
    /// This function allows the calculation priority
    private func calculationPriority() {
        var index = 0
        while index < elements.count {
            if elements[index] == "x" || elements[index] == "÷" {
                let newNumber = calcul(left: Double(elements[index - 1])!, operand: elements[index], right: Double(elements[index + 1])!)
                elements[index - 1] = ("\(clearResult(number: newNumber))")
                elements.remove(at: index)
                elements.remove(at: index)
                index = 0
            }
            index += 1
        }
    }
    /// This function manages the calculation and returns the result
    func calculateState() -> [String] {
        calculationPriority()
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            let result = calcul(left: left, operand: operand, right: right) 
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(clearResult(number: result))", at: 0)
        }
        //let result = ["\(clearResult(result: operationsToReduce))"]
        return ["\(operationsToReduce[0])"]
    }
    /// This is calculation function
    private func calcul(left : Double, operand : String, right : Double) -> Double {
        var result = 0.0
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "÷": result = left / right
        case "x": result = left * right
        default: fatalError("Unknown operator !")
        }
        return result
    }
    private func clearResult(number : Double) -> String {
        let stringNumber = String(number)
        let index = stringNumber.count - 1
        let cleanArray = Array(stringNumber)
        let lastNumber = cleanArray[index]
        if lastNumber != "0" {
            return "\(number)"
        }
        let result = Int(number)
        return "\(result)"
    }
}
