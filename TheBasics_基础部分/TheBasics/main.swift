//
//  main.swift
//  TheBasics
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

var str = "Hello, playground"

print(str)
print(str, terminator: "")

//let minValue = UInt8.min
//let maxValue = UInt8.max

let oneMillion = 1_000_000

print(oneMillion)

let twoMillion = 01000_000
print(twoMillion)

let pointOneFourOneFiveNine = 0.1415926
let pi = Double(3) + pointOneFourOneFiveNine

print(pi)

//元组,临时组织值得时候很有用
let http404Error = (404, "描述没有发现")
print(http404Error)

let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// 输出 "The status code is 404"
print("The status message is \(statusMessage)")
// 输出 "The status message is Not Found"


let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// 输出 "The status code is 404"

//直接使用下标进行表示
print("The status code is \(http404Error.0)")
// 输出 "The status code is 404"
print("The status message is \(http404Error.1)")
// 输出 "The status message is Not Found"

let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
// 输出 "The status code is 200"
print("The status message is \(http200Status.description)")
// 输出 "The status message is OK"

let http403Status: (Int, String) = (403, "状态码的表示")
print(http403Status)

let http503Status: (statusCode: Int, description: String) = (503, "状态码表示")
print(http503Status)

print("The status code is \(http503Status.statusCode)")
// 输出 "The status code is 503"
print("The status message is \(http503Status.description)")
// 输出 "The status message is OK"

//可选类型
//比如类型转换、可能失败
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

//现在convertedNumber是可选的
if let convertedNumber = convertedNumber {
    print(convertedNumber)
}

let possibleStringNumber: String = "hello, world"
let convertedStringNumber = Int(possibleStringNumber)
//print(convertedStringNumber) //这里打印出来是nil
if let convertedStringNumber = convertedStringNumber {
    //这里转换失败，这里是打印不出来的。
    print(convertedStringNumber)
}

var serverResponseCode: Int? = 404
// serverResponseCode 包含一个可选的 Int 值 404
serverResponseCode = nil
// serverResponseCode 现在不包含值

//对于不可选的不能进行设置
var serverRespondseCode1: String = ""
//serverRespondseCode1 = nil //这里报错 Nil cannot be assigned to type 'String'

var surveyAnswer: String?
// surveyAnswer 被自动设置为 nil

var serverResponseCodeStr: String? = nil

//swift中nil是一个确定的值、表示值缺失。

//if语句以及强制解析、可以和 == , != 来进行比较
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
// 输出 "convertedNumber contains some integer value."

if convertedNumber != nil {
    //这里是强制解析、因为我们已经判断过他有值、nil表示值缺失
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
// 输出 "convertedNumber has an integer value of 123."

//可选绑定

if let actualNumber = Int(possibleNumber) {
    //如果有值、赋值给一个常量actualNumber
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}
// 输出 "'123' has an integer value of 123"

if var actualNumber = Int(possibleNumber) {
    //如果有值、赋值给一个变量actualNumber
    actualNumber += 1;
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}
// 输出 "'123' has an integer value of 124"

//这里是且 && 的关系、全部成立才执行括号内内容
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// 输出 "4 < 42 < 100"

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// 输出 "4 < 42 < 100"

//隐式解析可选类型

let normalString: String = "An implicitly unwrapped optional string."
let normalGetString: String = normalString  // 不需要感叹号
//Cannot force unwrap value of non-optional type 'String', 不能强迫打开非可选类型

let assumedString: String! = "An implicitly unwrapped optional string."
var implicitString: String = assumedString  // 不需要感叹号

let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要感叹号来获取值

//let possibleString1: String! = nil
//let forcedString1: String = possibleString1 // 这里会有运行时错误。
//print(forcedString1)

//Nil cannot initialize specified type 'String',我们不能这样进行初始化，nil表示值缺失。并不是String类型。
//let possibleString2: String = nil
//let forcedString2: String = possibleString2

//
//这样仍然是可用的
if assumedString != nil {
    print(assumedString)
}
// 输出 "some("An implicitly unwrapped optional string.")"


if let definiteString = assumedString {
    print(definiteString)
}
// 输出 "An implicitly unwrapped optional string."

//错误处理

func canThrowAnError() throws {
    //这个函数可能抛出错误
}

do {
    try canThrowAnError()
    //没有错误消息抛出
} catch {
   //有一个错误消息抛出
}

//这里是一个枚举类型
enum SandwichError: Error {
    case outOfCleanDishes
    case missingIngredients(ingredients: String)
}

func makeASandwich() throws {
    // ...
}
func eatASandwich() {
    
}
func washDishes() {
    
}
func buyGroceries(_ ingredients: String) {
    
}
do {
    try makeASandwich()
    eatASandwich()
} catch SandwichError.outOfCleanDishes {
    washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
    buyGroceries(ingredients)
}

//断言调试？
let age = -3
//assert(age >= 0, "A person's age cannot be less than zero")
// 因为 age < 0，所以断言会触发

//这样也是可行的。
//assert(age >= 0)

//if age > 10 {
//    print("You can ride the roller-coaster or the ferris wheel.")
//} else if age > 0 {
//    print("You can ride the ferris wheel.")
//} else {
//    assertionFailure("A person's age can't be less than zero.")
//}

//强制执行先决条件
// 在一个下标的实现里...
//let index = -1
//precondition(index > 0, "Index must be greater than zero.")

//以上断言在unchecked模式编译代码会被忽视

//下面这个不会被忽视。
//fatalError("Unimplemented")









