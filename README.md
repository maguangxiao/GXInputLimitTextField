# GXInputLimitTextField
对UITextField输入文字限制的封装
###使用简介
该类可以在代码和xib中使用

所有的输入限制中，(若不限制位数 可传入Int.max)


>限制输入9位数字(若不限制位数 可传入Int.max)

```
let inputLimitTextField = GXInpuLimitTextField()
inputLimitTextField.inputLimitType = GXTextFieldInputLimitType.OnlyNumber(9)
```


> 限制输入首位非零的9位数字(若不限制位数 可传入Int.max)

```
let inputLimitTextField = GXInpuLimitTextField()
inputLimitTextField.inputLimitType = GXTextFieldInputLimitType.OnlyNumberExceptLeadingZero(9)
```

>限制输入手机号

```
let inputLimitTextField = GXInpuLimitTextField()
inputLimitTextField.inputLimitType = GXTextFieldInputLimitType.TelephoneNumber
```

>限制输入小数，整数4位 小数2位 (若不限制位数 可传入Int.max)

```
let inputLimitTextField = GXInpuLimitTextField()
inputLimitTextField.inputLimitType = GXTextFieldInputLimitType.DecimalNumber(4, 2)
```

>限制输入小数，整数2位，小数4位，且整数部分不能为0 (若不限制位数 可传入Int.max)

```
let inputLimitTextField = GXInpuLimitTextField()
inputLimitTextField.inputLimitType = GXTextFieldInputLimitType.DecimalNumberExceptLeadingZero(2, 4)
```

>限制输入身份证号

```
let inputLimitTextField = GXInpuLimitTextField()
inputLimitTextField.inputLimitType = GXTextFieldInputLimitType.IDCardNumber

```
>仅限制输入最大字符数为10

```
let inputLimitTextField = GXInpuLimitTextField()
inputLimitTextField.inputLimitType = GXTextFieldInputLimitType.MaxCharacter(10)
```

>其他自定义限制 在字符串位置传入正确的自定义正则表达式

```
let inputLimitTextField = GXInpuLimitTextField()
inputLimitTextField.inputLimitType = GXTextFieldInputLimitType.Express("^.*$")
```

ps:正则表达式的学习推荐一个网址：[30分钟学会正则表达式](https://deerchao.net/tutorials/regex/regex.htm#howtouse) 

虽然不是真的只花30分钟能学会，但绝对是一个深入浅出的好的学习教程

