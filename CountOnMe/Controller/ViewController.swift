//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    
    //MARK:- Variable
    private var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    /// Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    private var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    /// View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //MARK:- View actions
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    
    @IBAction private func tappedAdditionButton(_ sender: UIButton) {
        addOperation(operand: "+")
    }
    @IBAction private func tappedSubstractionButton(_ sender: UIButton) {
        addOperation(operand: "-")
    }
    @IBAction private func tappedMultiplicationButton(_ sender: Any) {
        addOperation(operand: "x")
    }
    @IBAction private func tappedDivisionButton(_ sender: Any) {
        addOperation(operand: "÷")
    }
    @IBAction func tappedDeletedButton(_ sender: Any) {
        let deleted = textView.text.count - 1
        var text = Array(textView.text)
        text.remove(at: deleted )
        textView.text = String(text)
    }
    
    ///Press the equal button which activates the calculation
    @IBAction private func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertExpression = alertUser(message: "Entrez une expression correcte !")
            return self.present(alertExpression, animated: true, completion: nil)
        }
        guard expressionHaveEnoughElement else {
            let alertCalcul = alertUser(message: "Démarrez un nouveau calcul !")
            return self.present(alertCalcul, animated: true, completion: nil)
        }
        /// Create local copy of operations
        var operationsToReduce = elements
        
        /// Iterate over operations while an operand still here
        let newCalcul = Calculation(elements: operationsToReduce)
        operationsToReduce = newCalcul.calculateState()
        textView.text.append(" = \(operationsToReduce.first!)")
    }
    //MARK:- Functions
    private func alertUser(message : String) -> UIAlertController{
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertVC
    }
    private func addOperation(operand : String) {
        if canAddOperator {
            textView.text.append(" \(operand) ")
        } else {
            let alertOperand = alertUser(message: "Un operateur est déja mis !")
            self.present(alertOperand, animated: true, completion: nil)
        }
    }
}
