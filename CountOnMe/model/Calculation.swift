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
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    ///Check if expression have enough element
     var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    /// Check if expression is calculable
    var isCalculable : Bool {
        for (index, _) in elements.enumerated() {
            if elements[index] == "÷" && elements[index + 1] == "0"{
                return false
            }
        }
        return true
    }
    init(elements : [String]) {
        self.elements = elements
    }
    /// This function allows the calculation priority
    private func calculationPriority() {
        var index = 0
        while index < elements.count {
            if elements[index] == "x" || elements[index] == "÷" {
                let newNumber = calcul(left: Double(elements[index - 1])!, operand: elements[index], right: Double(elements[index + 1])!)
                elements[index - 1] = ("\(newNumber)")
                elements.remove(at: index)
                elements.remove(at: index)
                
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
            operationsToReduce.insert("\(result)", at: 0)
        }
        let result = ["\(clearResult(result: operationsToReduce))"]
        
        return result
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
    /// This function removes the 0 after the decimal point
    private func clearResult(result : [String]) -> String {
        var cleanArray = Array(result[0])
        var i = 0
        var j = 0
        var numberBeforeComma : [String] = []
        var indexForDeleted1 = 0
        var indexForDeleted2 = 0
        var isCleanable = false
        
        guard cleanArray != ["0",".","0"] else {
            cleanArray.remove(at: 2)
            cleanArray.remove(at: 1)
            return String(cleanArray)
        }
        while j < cleanArray.count - 1 && cleanArray[j] != "."{
            let add = String(cleanArray[j])
            numberBeforeComma.append(add)
            j += 1
        }
        if let firstNumber = Int(numberBeforeComma[0]) {
            if firstNumber > 0 {
                while i < cleanArray.count - 1 {
                    if cleanArray[i] == "." && cleanArray[i + 1] == "0"{
                        isCleanable = true
                        indexForDeleted1 = i
                        indexForDeleted2 = i + 1
                    }
                    i += 1
                }
            }
        }
        guard isCleanable else {
            return String(cleanArray)
        }
        cleanArray.remove(at: indexForDeleted2)
        cleanArray.remove(at: indexForDeleted1)
        return String(cleanArray)
    }
}
