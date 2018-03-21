//
//  ViewController.swift
//  GXInputLimitTextField
//
//  Created by GuangXiao on 2018/3/21.
//  Copyright © 2018年 guangxiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstTextField: GXInputLimitTextField!
    
    @IBOutlet weak var secondTextField: GXInputLimitTextField!
    
    @IBOutlet weak var thirdTextField: GXInputLimitTextField!
    
    @IBOutlet weak var fourthTextField: GXInputLimitTextField!
    
    @IBOutlet weak var fifthTextField: GXInputLimitTextField!
    
    @IBOutlet weak var sixthTextField: GXInputLimitTextField!
    
    @IBOutlet weak var seventhTextField: GXInputLimitTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firstTextField.inputLimitType = GXTextFieldInputLimitType.OnlyNumber(9)
        secondTextField.inputLimitType = GXTextFieldInputLimitType.OnlyNumberExceptLeadingZero(9)
        thirdTextField.inputLimitType = GXTextFieldInputLimitType.TelephoneNumber
        fourthTextField.inputLimitType = GXTextFieldInputLimitType.DecimalNumber(4, 2)
        fifthTextField.inputLimitType = GXTextFieldInputLimitType.DecimalNumberExceptLeadingZero(2, 4)
        sixthTextField.inputLimitType = GXTextFieldInputLimitType.IDCardNumber
        seventhTextField.inputLimitType = GXTextFieldInputLimitType.MaxCharacter(10)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}






















