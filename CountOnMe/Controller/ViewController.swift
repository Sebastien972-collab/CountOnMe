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
    
    private var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    let calculator = Calculation()
    /// View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK:- View actions
    ///Allows you to add number
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    ///Allows you to add the operator
    @IBAction private func tappedOperandButton(_ sender: UIButton) {
        calculator.setExpression(elements: elements)
        guard calculator.canAddOperator else {
            present(alertUser(message: "Vous ne pouvez pas ajouté d'opérateur ici"), animated: true, completion: nil)
            return
        }
        guard let operandText = sender.title(for: .normal) else {
            return
        }
        addOperation(operand: operandText)
    }
    ///Allows the user to remove the keyboard by typing outside the textview
    @IBAction private func dissmissKeyboard(_ sender: UITapGestureRecognizer) {
        textView.resignFirstResponder()
    }
    ///Delete an element of the expression
    @IBAction private func tappedDeletedButton(_ sender: Any) {
        guard textView.text.first != nil else {
            present(alertUser(message: "Il n'y a pas d'élement à effacer"), animated: true, completion: nil)
            return
        }
        var text = Array(textView.text)
        text.remove(at: textView.text.count - 1)
        textView.text = String(text)
    }
    ///Erase the whole expression with a long press
    @IBAction private func longPressDeletedButton(_ sender: UILongPressGestureRecognizer) {
        textView.text.removeAll()
    }
    ///Press the equal button which activates the calculation
    @IBAction private func tappedEqualButton(_ sender: UIButton) {
        /// Create local copy of operations
        var operationsToReduce = elements
        calculator.setExpression(elements: operationsToReduce)
        /// Iterate over operations while an operand still here
        guard calculator.expressionIsCorrect else {
            return self.present(alertUser(message: "Entrez une expression correcte !"), animated: true, completion: nil)
        }
        guard calculator.expressionHaveEnoughElement else {
            return self.present(alertUser(message: "Démarrez un nouveau calcul !"), animated: true, completion: nil)
        }
        guard calculator.isCalculable else {
            return self.present(alertUser(message: "Votre calcul est impossible"), animated: true) {
                self.textView.text.removeAll()
            }
        }
        operationsToReduce = calculator.calculateState()
        textView.text.append(" = \(operationsToReduce.first!)")
    }
    //MARK:- Functions
    /// A function that allows you to create alerts by entering a message
    private func alertUser(message : String) -> UIAlertController{
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertVC
    }
    /// Checks if the user can add an operand
    private func addOperation(operand : String) {
        calculator.setExpression(elements: elements)
        if calculator.canAddOperator {
            textView.text.append(" \(operand) ")
        } else {
            self.present(alertUser(message: "Un operateur est déja mis !"), animated: true, completion: nil)
        }
    }
    
}
