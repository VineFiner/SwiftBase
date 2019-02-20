//
//  main.swift
//  Functions
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 函数

// person是形参
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

// 字符串 "Anna"是实参
print(greet(person: "Anna"))
// 打印 "Hello, Anna!"
print(greet(person: "Brian"))
// 打印 "Hello, Brian!"

// 我们可以简化为如下格式
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
// 打印 "Hello again, Anna!"

// 无参函数
// 尽管这个函数没有参数， 但是定义中在函数名后还是需要一对圆括号。
// 当被调用时，也需要在函数名后写一对圆括号。

func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// 打印 "hello, world"

// 多参函数
// 函数可以有多种输入参数，这些参数被包含在函数的括号中，以逗号分隔。

func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        // 这里我们可以调用另一个函数
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))
// 打印 "Hello again, Tim!"

// 无返回值函数
// 这里依然会返回一个特殊的Void值， 这个值是一个空元组。没有任何元素，可以写成（）
func greet1(person: String) {
    print("Hello, \(person)!")
}

greet1(person: "Dave")
// 打印 "Hello, Dave!"

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world") //Result of call to 'printAndCount(string:)' is unused
// 我们可以忽略一个函数的返回值，这里编译器会给我们一个警告
// 打印 "hello, world" 并且返回值 12
printWithoutCounting(string: "hello, world")
// 打印 "hello, world" 但是没有返回任何值

// 多重返回值函数
// 这里我们可以使用元组来实现这个多重返回值。

func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    //这里是循环比较
    // 这里是剔除了第一个数
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// 打印 "min is -6 and max is 109"
// 这里元组的成员不需要在元组从函数中返回时命名，因为他们的名字已经在函数返回类型中指定了。

// 可选元组返回类型

func minMax1(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds1 = minMax1(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds1.min) and max is \(bounds1.max)")
}
// 打印 "min is -6 and max is 109"


//参数标签和参数名
// 参数标签是在调用函数的时候使用的。
// 参数名是在函数的实现中使用的。
// 默认情况下，函数参数使用参数名称作为他们的标签。

func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction(firstParameterName: 1, secondParameterName: 2)

// 参数名、即函数实现中使用的名字必须唯一。
// 函数标签可以使相同的，但是不建议使用相同标签。


// 指定参数标签
func someFunction(argumentLabel parameterName: Int) {
    // 在函数体内，parameterName 代表参数值
    // 这里parameterName代表参数名
}

// argumentLabel 代表参数标签
//someFunction(argumentLabel: <#T##Int#>)

// 其中hometown 是形参
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
// 其中 字符串 "Cupertino"为实参
// 其中 from 是函数标签
print(greet(person: "Bill", from: "Cupertino"))
// 打印 "Hello Bill!  Glad you could visit from Cupertino."


// 忽略参数标签
//如果一个参数有一个标签，那么在调用的时候必须使用标签来标记这个参数。
// 默认参数名 为函数标签

func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
//someFunction(<#T##firstParameterName: Int##Int#>, secondParameterName: <#T##Int#>)
someFunction(1, secondParameterName: 2)


// 默认参数
// 你可以在函数体中通过给参数赋值来为任意一个参数定义默认值（Deafult Value）。当默认值被定义后，调用这个函数时可以忽略这个参数。
// 将不带有默认值的参数放在函数参数列表的最前面。
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
}
//someFunction(parameterWithoutDefault: <#T##Int#>, parameterWithDefault: <#T##Int#>)
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault = 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault = 12



// 可变参数
// 一个可变参数，可以接受 0 个 或多个值。
// 通过在变量类型名后面加入 ...
// 最多只能拥有一个可变参数

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

print(arithmeticMean(1, 2, 3, 4, 5))
// 返回 3.0, 是这 5 个数的平均数。
print(arithmeticMean(3, 8.25, 18.75))
// 返回 10.0, 是这 3 个数的平均数。


//In-Out 参数
// 函数参数默认是常量，如果想改变外部参量，需要定义一个输入输出参数
// 这里需要 inout 关键字
// 你只能传递变量给输入输出参数
// 需要在参数名前夹 & 符号

// b 参数忽略函数标签
func swapTwoInts(a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// 这里调用的话， 需要在实参 前加 &
// 这里我们只能传递变量

var  someInt = 3
var anotherInt = 107
swapTwoInts(a: &someInt, &anotherInt)

print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// 打印 "someInt is now 107, and anotherInt is now 3"


// MARK: 函数类型

// 每个函数都有种特定的函数类型，函数类型由函数的参数类型和返回值类型组成

// 例如 (Int, Int) -> Int 类型
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
// 上面两个函数属于同一种类型

// () -> Void 类型
func printHelloWorld() {
        print("hello, world")
}

// 使用函数类型
var mathFunction: (Int, Int) -> Int = addTwoInts(_:_:)

print("Result: \(mathFunction(2, 3))")
// Prints "Result: 5"

// 相同匹配类型的函数可以赋值给同一变量，
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")
// Prints "Result: 6"

// 类型推断
let anotherMathFunction = addTwoInts
// anotherMathFunction 被推断为 (Int, Int) -> Int 类型

// MARK: 函数类型作为参数类型

//你可以用 (Int, Int) -> Int 这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给函数的调用者来提供。

func printMathResult(parameter mathFunction: (Int, Int) -> Int, parameter a: Int, parameter b: Int) -> Void {
    print("Result: \(mathFunction(a, b))")
}

//printMathResult(parameter: <#T##(Int, Int) -> Int#>, parameter: <#T##Int#>, parameter: <#T##Int#>)
printMathResult(parameter: mathFunction, parameter: 3, parameter: 5)

// MARK: 函数类型作为返回类型

// 前进一步
func stepForward(_ input: Int) -> Int {
    return input + 1
}
// 后退一步
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    if backward {
        return stepBackward(_:)
    } else {
        return stepForward
    }
}

//现在调用函数
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero 现在指向 stepBackward() 函数。
print(moveNearerToZero) // 这里打印是 Function
print(moveNearerToZero(currentValue)) // 这里打印是 2
print(chooseStepFunction(backward: currentValue > 0)(currentValue)) // 这里打印是 2

// 用来数到 0
print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!


// MARK: 嵌套函数

// 1、 默认情况下嵌套函数对外界不可见。
// 2、 一个外围函数可以返回它的某一个嵌套函数

func chooseStepFunction1(backward: Bool) -> (Int) -> Int {
    // 默认情况下， 嵌套函数外部不可见
    func stepForward(input: Int) -> Int { return input + 2 }
    func stepBackward(input: Int) -> Int { return input - 2 }
    return backward ? stepBackward : stepForward
}

var currentValue1 = 8
let moveNearerToZero1 = chooseStepFunction1(backward: currentValue1 > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue1 != 0 {
    print("\(currentValue1)... ")
    currentValue1 = moveNearerToZero1(currentValue1)
}
print("zero!")






