//
//  GXInputLimitTextField.swift
//  GXInputLimitTextField
//
//  Created by GuangXiao on 2018/3/21.
//  Copyright © 2018年 guangxiao. All rights reserved.
//

import UIKit
/**
 GXInputLimitTextField的输入限制类型
 
 - None:                 什么都不限制
 - OnlyNumber:           只允许输入数字 并限制输入数字的最大位数
 - OnlyNumberExceptLeadingZero: 只允许输入数字 且首位不为零 并限制输入的最大位数
 - TelephoneNumber:      电话号码 默认限制11位
 - DecimalNumber:        小数 分别限制整数部分和小数部分位数
 - DecimalNumberExceptLeadingZero:输入小数 且首位不为零 分别限制整数部分和小数部分位数
 - IDCardNumber:         身份证件号码
 - MaxCharacter:         只限制最大数
 - Express:              自定义的正则表达式
 */
enum GXTextFieldInputLimitType {
    case None
    case OnlyNumber(Int)
    case OnlyNumberExceptLeadingZero(Int)
    case TelephoneNumber
    case DecimalNumber(Int,Int)
    case DecimalNumberExceptLeadingZero(Int,Int)
    case IDCardNumber
    case MaxCharacter(Int)
    case Express(String)
    /**
     该限制类型的正则表达式
     
     - returns: 正则表达式字符串
     */
    func regularExpression()->String{
        var expression:String = "^.*$"
        
        switch self {
            
        case .TelephoneNumber:
            expression = "^[0-9]{0,11}$"
            
        case .DecimalNumber(let integerMaxCount, let decimalMaxCount):
            if integerMaxCount == Int.max && decimalMaxCount == Int.max{
                expression = "(^[0]|^[1-9][0-9]*)(\\.[0-9]*)?$"
            }else if integerMaxCount == Int.max{
                expression = "(^[0]|^[1-9][0-9]*)(\\.[0-9]{0,\(decimalMaxCount)})?$"
            }else if decimalMaxCount == Int.max{
                expression = "(^[0]|^[1-9][0-9]{0,\(integerMaxCount-1)})(\\.[0-9]*)?$"
                
            }else{
                expression = "(^[0]|^[1-9][0-9]{0,\(integerMaxCount-1)})(\\.[0-9]{0,\(decimalMaxCount)})?$"
            }
        case .DecimalNumberExceptLeadingZero(let integerMaxCount, let decimalMaxCount):
            if integerMaxCount == Int.max && decimalMaxCount == Int.max{
                expression = "(^[1-9][0-9]*)(\\.[0-9]*)?$"
            }else if integerMaxCount == Int.max{
                expression = "(^[1-9][0-9]*)(\\.[0-9]{0,\(decimalMaxCount)})?$"
            }else if decimalMaxCount == Int.max{
                expression = "(^[1-9][0-9]{0,\(integerMaxCount-1)})(\\.[0-9]*)?$"
                
            }else{
                expression = "(^[1-9][0-9]{0,\(integerMaxCount-1)})(\\.[0-9]{0,\(decimalMaxCount)})?$"
            }
            
        case .IDCardNumber:
            expression = "^[0-9]{0,17}[0-9Xx]$"
            break
            
        case .MaxCharacter(let characterMaxCount):
            if characterMaxCount == Int.max{
                
                expression = "^.*$"
            }else{
                expression = "^.{0,\(characterMaxCount)}$"
            }
            break
            
        case .OnlyNumber(let integerMaxCount):
            if integerMaxCount == Int.max{
                expression = "^\\d*$"
            }else{
                expression = "^\\d{0,\(integerMaxCount)}$"
            }
            break
            
        case .OnlyNumberExceptLeadingZero(let integerMaxCount):
            if integerMaxCount == Int.max{
                expression = "^[1-9][0-9]*$"
            }else{
                expression = "^[1-9][0-9]{0,\(integerMaxCount-1)}$"
            }
            break
        case .Express(let exp):
            expression = exp
        default:
            break
        }
        return expression
    }
    
    func keyboardType()->UIKeyboardType{
        var keyboardType = UIKeyboardType.default
        switch self {
        case .OnlyNumberExceptLeadingZero(_),.OnlyNumber(_),.TelephoneNumber:
            keyboardType = .numberPad
        case .DecimalNumber(_, _):
            keyboardType = .decimalPad
        case .MaxCharacter(_):
            keyboardType = .default
        case .IDCardNumber:
            keyboardType = .namePhonePad
        default:
            keyboardType = .default
        }
        return keyboardType
    }
}
@IBDesignable
class GXInputLimitTextField: UITextField {
    
    
    var inputLimitType:GXTextFieldInputLimitType{
        set{
            _inputLimitType = newValue
            limitInputDelegate.inputLimitType = inputLimitType
            self.delegate = limitInputDelegate
            self.keyboardType = inputLimitType.keyboardType()
        }
        get{
            return _inputLimitType
        }
    }
    private var _inputLimitType:GXTextFieldInputLimitType = GXTextFieldInputLimitType.None

    private var limitInputDelegate = GXInputLimitTextFieldDelegate()
    
}


class GXInputLimitTextFieldDelegate:NSObject,UITextFieldDelegate{
    
    var inputLimitType:GXTextFieldInputLimitType = GXTextFieldInputLimitType.None
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /// 文本框中已经展示的文字
        let alreadyText = textField.text ?? ""
        /// 已经展示的文字加上新输入的文字 组成即将展示的完整文字
        let newString = (alreadyText as NSString).replacingCharacters(in: range, with: string)
        
        //只有当即将展示的文字不为空时才需要进行正则表达的判断
        if newString.count > 0{
            /// 获取正则表达式
            let expression = inputLimitType.regularExpression()
            /// 获取匹配结果
            let result = matchStringFormat(matchedStr: newString, withRegex: expression)
            //ps:(newString.length < alreadyText.length)是为了防止意外情况导致的错误信息已录入时， 删除功能无法使用的情况， 就算不符合正则表达式， 删除永远是允许的。
            return result || (newString.count < alreadyText.count)
        }
        
        /**
         ps:当即将展示的字符串的字符数量为0时 意味着是删除 所以是允许改变的
         如果此时进行正则表达式的判断 会导致第一个输入的字符无法被删除
         */
        return true
    }
    
    func matchStringFormat(matchedStr:String, withRegex regex:String  )->Bool{
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        let result = predicate.evaluate(with: matchedStr)
        
        return result
    }
    
}
