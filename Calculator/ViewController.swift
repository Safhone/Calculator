//
//  ViewController.swift
//  Calculator
//
//  Created by Soeng Saravit on 10/25/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var operandLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var plusMinusButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    
    var operation: String? = ""
    var secondPerforming: Bool = false
    var strFirstOperand: String? = ""
    var strOperand: String? = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.zeroButton.addTarget(self, action: #selector(numbers(sender:)), for: .touchUpInside)
        self.oneButton.addTarget(self, action: #selector(numbers(sender:)), for: .touchUpInside)
        self.twoButton.addTarget(self, action: #selector(numbers(sender:)), for: .touchUpInside)
        self.threeButton.addTarget(self, action: #selector(numbers(sender:)), for: .touchUpInside)
        self.fourButton.addTarget(self, action: #selector(numbers(sender:)), for: .touchUpInside)
        self.fiveButton.addTarget(self, action: #selector(numbers(sender:)), for: .touchUpInside)
        self.sixButton.addTarget(self, action: #selector(numbers(sender:)), for: .touchUpInside)
        self.sevenButton.addTarget(self, action: #selector(numbers(sender:)), for: .touchUpInside)
        self.eightButton.addTarget(self, action: #selector(numbers(sender:)), for: .touchUpInside)
        self.nineButton.addTarget(self, action: #selector(numbers(sender:)), for: .touchUpInside)
        self.dotButton.addTarget(self, action: #selector(numbers(sender:)), for: .touchUpInside)
        
        self.clearButton.addTarget(self, action: #selector(operation(sender:)), for: .touchUpInside)
        self.plusMinusButton.addTarget(self, action: #selector(operation(sender:)), for: .touchUpInside)
        self.percentButton.addTarget(self, action: #selector(operation(sender:)), for: .touchUpInside)
        self.divideButton.addTarget(self, action: #selector(operation(sender:)), for: .touchUpInside)
        self.multiplyButton.addTarget(self, action: #selector(operation(sender:)), for: .touchUpInside)
        self.minusButton.addTarget(self, action: #selector(operation(sender:)), for: .touchUpInside)
        self.plusButton.addTarget(self, action: #selector(operation(sender:)), for: .touchUpInside)
        self.equalButton.addTarget(self, action: #selector(operation(sender:)), for: .touchUpInside)
        
    }
    var firstOperand: String = ""
    var secondOperand: String = ""
    var lastestSign: String = ""
    var isFirstOperand: Bool = true
    var removeLastSign: Bool = false

    var lastResult: Double = 0
    var isReset: Bool = false
    var countNumber = 1
    @objc func numbers(sender: UIButton) {
        
        if countNumber <= 9 {
        
            if isFirstOperand == true {
                firstOperand = firstOperand + sender.currentTitle!
                resultLabel.text = firstOperand
            }else{
                secondOperand = secondOperand + sender.currentTitle!
                resultLabel.text = secondOperand
            }
            
            if isReset == true {
                operandLabel.text = ""
                isReset = false
            }
            
            operandLabel.text = operandLabel.text! + sender.currentTitle!
            
            countNumber = countNumber + 1
        }
        
    }
    
    
    @objc func cal(sign: String)->Double{
        //set operandLabel
        
        operandLabel.text = resultLabel.text! + sign
        countNumber = 1
        
        if secondOperand != "" {
            if sign == "+" {
                lastResult = Double(firstOperand)! + Double(secondOperand)!
            } else if sign == "-" {
                lastResult = Double(firstOperand)! - Double(secondOperand)!
            } else if sign == "×" {
                lastResult = Double(firstOperand)! * Double(secondOperand)!
            } else if sign == "÷" {
                lastResult = Double(firstOperand)! / Double(secondOperand)!
            } else if sign == "%" {
                lastResult = Double(firstOperand)!.truncatingRemainder(dividingBy: Double(secondOperand)!)
            } else if sign == "+/-" {
                if lastResult >= 0 {
                    lastResult = Double(firstOperand)! * -1
                }else {
                    lastResult = abs(Double(firstOperand)!)
                }
            }
            firstOperand = String(lastResult)
            
            // make the second operand not to concat with the old value when action of operator is used more than one
            secondOperand = ""
            if removeLastSign == true {
                operandLabel.text = String(format: "%g", lastResult)
                removeLastSign = false
            } else {
                 operandLabel.text = String(format: "%g", lastResult) + sign
            }
        }else{
        
            lastResult = Double(firstOperand)!
        }
        return lastResult
    }
 
    @objc func operation(sender: UIButton) {
        if resultLabel.text != "" && sender.currentTitle != "C"{
            isFirstOperand = false
            var tmpResult: Double = 0
            
            if sender.currentTitle == "+" {
                tmpResult = cal(sign:"+")
            } else if sender.currentTitle == "-" {
                tmpResult = cal(sign: "-")
            } else if sender.currentTitle == "×" {
                tmpResult = cal(sign: "×")
            } else if sender.currentTitle == "÷" {
                tmpResult = cal(sign: "÷")
            } else if sender.currentTitle == "=" {
                removeLastSign = true
                isReset = true
                tmpResult = cal(sign: lastestSign)
                //clear()
                operandLabel.text = String(format: "%g", tmpResult)
                
            } else if sender.currentTitle == "%" {
                tmpResult = cal(sign: "%")
            } else if sender.currentTitle == "+/-" {
                // set second operator in order to cal
                secondOperand = "1"
                tmpResult = cal(sign: "+/-")
            }
            
            lastestSign = sender.currentTitle!
            resultLabel.text = String(format: "%g", tmpResult)
            
        
        }else if sender.currentTitle == "C" {
            clear()
        }
        
    }
    
    @objc func clear() {
        operandLabel.text = ""
        resultLabel.text = "0"
        firstOperand = ""
        secondOperand = ""
        lastestSign = ""
        isFirstOperand = true
        lastResult = 0
        removeLastSign = false
        countNumber = 1
        
    }
    
}

@IBDesignable class customButton: UIButton {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
           self.layer.cornerRadius = self.cornerRadius
        }
    }
}
