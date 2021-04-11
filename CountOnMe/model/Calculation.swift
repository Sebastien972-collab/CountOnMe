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
    private var elements : [String] = []
    /// Error check computed variables
     var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
     var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
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
        return operationsToReduce
    }
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
}

