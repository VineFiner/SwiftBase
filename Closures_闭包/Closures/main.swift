//
//  main.swift
//  Closures
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// MARK: 闭包
// 全局函数是一个有名字但不会捕获任何值的闭包
// 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
// 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包


//这里使用排序闭包
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
print(reversedNames)

// 闭包表达式
// 闭包表达式的标志大括号
// 下面这个就是一个闭包
let testClosures = {
    
}
print(testClosures);

// 函数类型和返回值都在大括号内
// 函数类型在小括号内
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

// 可以根据上下文推断类型

reversedNames = names.sorted(by: { s1, s2 -> Bool in s1 > s2 })

// 单表达式，隐式返回
reversedNames = names.sorted(by: {s1, s2 in s1 > s2})
print(reversedNames);
// 参数名称缩写
reversedNames = names.sorted(by: {$0 > $1})
// 运算符方法
reversedNames = names.sorted(by: >)

// MAKR: 尾随闭包

// 下列函数是错误的
// Function types cannot have argument labels
// https://github.com/apple/swift-evolution/blob/master/proposals/0111-remove-arg-label-type-significance.md
// 这是一个悲伤的故事😭
//func printMathResult(mathFunction: (a: Int, b: Int) -> Int, _ a: Int, _ b: Int) {
//    print("Result: \(mathFunction(a, b))")
//}

/// 现在只有这种写法，嵌套函数
///
/// - Parameters:
///   - mathFunction: 数学方法函数
///   - a: 参数 a
///   - b: 参数 b

func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
/// 没有标签的嵌套函数
///
/// - Parameters:
///   - mathFunction: 闭包表达式
///   - a: 参数a
///   - b: 参数b
func printMathResult1(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

func printMathResult2( _ a: Int, _ b: Int, _ mathFunction: (Int, Int) -> Int) {
    print("Result: \(mathFunction(a, b))")
}

func addTwoInts(a: Int, b: Int) -> Int {
    return a + b;
}
var mathFunction: (Int, Int) -> Int = addTwoInts

printMathResult(mathFunction: addTwoInts, 3, 5)
printMathResult(mathFunction: mathFunction, 2, 4)
printMathResult1(mathFunction, 7, 7)
// 这里使用闭包的形式实现这个函数
printMathResult(mathFunction: { (a: Int, b: Int) -> Int in
    return a * b;
}, 11, 6)

// 如果我们把闭包表达式作为最后一个参数传递给函数，我们可以使用尾随闭包来增强函数的可读性。

/// 尾随闭包例子
///
/// - Parameter closure: 这个参数是一个闭包
/// 这个闭包类似无参无返回值函数
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
}

//这里不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure {
    // 这里是闭包主体
}

printMathResult1({ (a: Int, b: Int) -> Int in
    // 这里是闭包主体
    return a * b;
}, 7, 7)

printMathResult2(9, 9, { (a: Int, b: Int) -> Int in
    return a * b;
})
// 这里使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 这里是闭包主体部分
}

printMathResult2(9, 9) { (x: Int, y: Int) -> Int in
    // 这里是闭包主体
    return x * y;
}
printMathResult2(9, 9) { $0 * $1 }
print("闭包类型以及主体在大括号里面")
// 如果闭包表达式是函数或方法的唯一参数，当使用尾随闭包是，可以省略（）
reversedNames = names.sorted {$0 > $1}


//
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510, 233, 8734]

let strings = numbers.map { (number: Int) -> String in
    var number = number
    var output = ""
    // 这里是转换规则
    // 这里是 do while 类似的循环
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

print("转换结果是:", strings)

// MARK: 值捕获
// 闭包可以在器被定义的航下文中捕获常量或变量，及时定义这些常量和变量的原作用域已经不存在，
// 闭包仍然可以在闭包函数体内医用和修改这些值。
// swift中， 可以捕获值的闭包的最简单形式是嵌套函数。也就是定义在其他函数的函数体内的函数。
// 嵌套函数可以捕获其外部函数所有的参数以及定义的变量和常量。

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    print("这里是形参:", amount)
    var runningTotal = 0
    print("函数内变量:\(runningTotal): 接收常量:\(amount)")
    // 这个是嵌套函数
    func incrementer() -> Int {
        // 这个函数捕获了 runningTotal 和 amount 变量。
        // amount
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

for _ in 0...5 {
    print("这是一个无参，返回值类型为Int的函数", incrementByTen())
}
let alsoIncrementByTen = incrementByTen
print(alsoIncrementByTen())

// 闭包是一个强引用

// MARK: 逃逸闭包
// 当一个闭包作为参数传递到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。


/// 这是一个数组，数组里面是函数
func finishCompletion() {
    print("这个是一个测试函数")
}
var completionHandlerClosure: () -> Void = finishCompletion
var completionHandlerClosure1: () -> Void = finishCompletion

var completionInt: Int = 0

/// 逃逸闭包
///
/// - Parameter completionHandler: 闭包表达式
// 必须在闭包中显示的使用self
// 非逃逸闭包可以隐式引用self
func someFunctionWithEscapingClosure(tab1: Int, completionHandler: @escaping () -> Void) -> Void {
    // 这里是把这个函数存了起来
//    completionHandlers.append(completionHandler)
    completionHandlerClosure = completionHandler
    completionInt = tab1 * 2
}

func someFunctionWithNonescapingClosure(tab1: Int, closure: () -> Void) {
    // 这里并不让外部变量持有这个闭包, 这个会报错
//    completionHandlerClosure1 = closure
    closure();
    completionInt = tab1 + 1
}

// 定义一个类
class SomeClass {
    var x = 10
    func doSomething() {
        
        //这里都是尾随闭包
        someFunctionWithEscapingClosure(tab1: 3) {
            // 这里必须显示使用self
            self.x = 100
        }
        
        someFunctionWithNonescapingClosure(tab1: 3) {
            // 这里可以隐式使用self
            x = 200
        }
    }
    
    // 这里定义一个非逃逸闭包函数
    func testFunctionWithNonescapingClosure(closure: (Int) -> Void ){
//        for index in 1...3 {
//            sleep(1)
//            print("This is sleep:\(index)")
//        }
        //这里是直接调用闭包函数
        closure(3);
    }
    // 这里定义一个逃逸闭包函数
    func testFunctionWithEscapingClosure(completionHandler: @escaping (Int) -> Void) {
//        for index in 1...3 {
//            sleep(1)
//            print("This is sleep:\(index)")
//        }
        //这里直接调用闭包函数
        completionHandler(5)
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x, completionInt)
// 打印出 "200"

// 调用外部持有的闭包
completionHandlerClosure()
print(instance.x, completionInt)
// 打印出 "100"

//completionHandlers.first?()
//print(instance.x)
// 打印出 "100"

// 这里是函数的调用
let someInstance = SomeClass()
// 这里是逃逸闭包的调用
print("Begin escappingClosure")
someInstance.testFunctionWithEscapingClosure { (a: Int) in
    //这里进行处理
    print("This is Escaping:\(a)")
}

//这里是非逃逸闭包的调用
print("Begin NonescapingClosure")
someInstance.testFunctionWithNonescapingClosure { (a: Int) in
    //这里进行处理
    print("This is Nonescaping:\(a)")
}


// MARK: 自动闭包

//自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// 打印出 "5"

// 现在定义一个闭包
// 就是只有一个花括号的闭包
let customerProvider = {
    customersInLine.remove(at: 0)
}

// 现在这个闭包没有调用
print(customersInLine.count)
// 打印出 "5"

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// 打印出 "4"

func serve(customer customerProvider: () -> String) {
    // 这是一个无参，返回值为String的函数
    let str = customerProvider()
    print("Now serving \(str)")
}

//现在开始调用我们的函数
serve(customer: {
    customersInLine.remove(at: 0)
} )

// 打印出 "Now serving Alex!"

//serve { () -> String in
//    let str = customersInLine.remove(at: 0)
//    return str
//}
//
//// 打印出 "Now serving Ewa!"

// customersInLine is ["Ewa", "Barry", "Daniella"]
// 这里接收的是一个自动闭包
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// 打印 "Now serving Ewa!"

// customersInLine i= ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// 打印 "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// 打印 "Now serving Barry!"
// 打印 "Now serving Daniella!"











