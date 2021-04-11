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
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    private var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    /// View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction private func tappedOperandButton(_ sender: UIButton) {
        guard let operandText = sender.title(for: .normal) else {
            return
        }
        addOperation(operand: operandText)
        
    }
    @IBAction func dissmissKeyboard(_ sender: Any) {
        textView.resignFirstResponder()
    }
    @IBAction private func tappedDeletedButton(_ sender: Any) {
        guard textView.text.first != nil else {
            present(alertUser(message: "Il n'y a pas d'élement à effacer"), animated: true, completion: nil)
            return
        }
        var text = Array(textView.text)
        text.remove(at: textView.text.count - 1 )
        textView.text = String(text)
    }
    ///Press the equal button which activates the calculation
    @IBAction private func tappedEqualButton(_ sender: UIButton) {
        /// Create local copy of operations
        var operationsToReduce = elements
        /// Iterate over operations while an operand still here
        let newCalcul = Calculation(elements: operationsToReduce)
        guard newCalcul.expressionIsCorrect else {
            return self.present(alertUser(message: "Entrez une expression correcte !"), animated: true, completion: nil)
        }
        guard newCalcul.expressionHaveEnoughElement else {
            return self.present(alertUser(message: "Démarrez un nouveau calcul !"), animated: true, completion: nil)
        }
        guard newCalcul.isCalculable else {
            return self.present(alertUser(message: "Votre calcul est impossible"), animated: true) {
                self.textView.text = " "
            }
        }
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
            self.present(alertUser(message: "Un operateur est déja mis !"), animated: true, completion: nil)
        }
    }
}
