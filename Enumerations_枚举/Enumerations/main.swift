//
//  main.swift
//  Enumerations
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 枚举为一组相关的值定义了一个共同的类型，使你可以在你的代码中以类型安全的方式来使用这些值。
// 可以给枚举提供一个原始值， 该原始值类型可以使字符串，字符，或是一个整型值或浮点值。
// 在Swift中， 枚举类型是一等类型。。

// MARK: 枚举语法
// 使用enum关键字来创建枚举
enum SomeEnumeration {
    // 枚举定义放在这里
}
// 定义方向的例子
enum CompassPoint {
    case north  // 北方
    case south  // 南方
    case east   // 东方
    case west   // 西方
}

// Swift中的枚举成员被常见时，不会被赋予一个默认的整型值。不会隐式的赋值为0、1、2、3
// Swift中的成员变量本身就是完备的值。这些值的类型已经是明确定义好的CompassPoint类型

// 这里可以在同一行上，用逗号隔开
// 这个是已经明确定义好的 Planet类型
enum Planet {
    case mercury, venus, earth, marsm, jupiter, saturn, uranus, neptune
}

// 这里相当于一个确定的类型
var directionToHead = CompassPoint.west
print(":\(CompassPoint.self), :\(directionToHead.self)")

directionToHead = .east
print(CompassPoint.self, directionToHead)

// 这里使用 Switch语句匹配枚举值
directionToHead = .south

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// 打印 "Mostly harmless”
switch directionToHead {
    case .north:
        print("Lots of planets have a north")
    case .south:
        print("Watch out for penguins")
    case .east:
        print("Where the sun rises")
    case .west:
        print("Where the skies are blue")
}
// 打印 "Watch out for penguins”

// MARK: 关联值

// 关联值可以使任何类型

// 重新定义一个枚举类型，这个枚举类型是 Barcode
enum Barcode {
    case upc(Int, a: Int, Int, Int)
    case qrCode(String)
}

//“定义一个名为Barcode的枚举类型，它的一个成员值是具有(Int，Int，Int，Int)类型关联值的upc，另一个成员值是具有String类型关联值的qrCode。”

var productBarcode = Barcode.upc(8, a: 85909, 51226, 3)

print("This is detail:\(productBarcode)")
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// 打印 "QR code: ABCDEFGHIJKLMNOP."

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// 输出 "QR code: ABCDEFGHIJKLMNOP."


// MARK: 原始值
// 这些原始值的类型必须相同
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// 原始值的隐式赋值
enum Planet1: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPoint1: String {
    case north, south, east, west
}

var directionToHead1 = CompassPoint1.west
print("现在这个是测试类型:\(CompassPoint1.self), :\(directionToHead1.self)")

let earthsOrder = Planet1.earth.rawValue
// earthsOrder 值为 3
print(earthsOrder)
let sunsetDirection = CompassPoint1.west.rawValue
// sunsetDirection 值为 "west"
print(sunsetDirection)


// 使用原始值初始化枚举类型
let possiblePlanet = Planet1(rawValue: 7)
// possiblePlanet 类型为 Planet? 值为 Planet.uranus

// 原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员。
let positionToFind = 11
if let somePlanet = Planet1(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// 输出 "There isn't a planet at position 11

// MARK: 递归枚举
// 递归枚举是一种枚举类型，他有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加入 indirect来表示该成员可递归
// 是一个完备的类型、和 Int、 String 类型是一致的。
enum ArithmeticExpression {
    case number(Int)
    // 这里是可递归的枚举成员
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// 上面定义的枚举类型可以存储三种算术表达式：纯数字、两个表达式相加、两个表达式相乘。

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

// 直接使用递归函数
func evaluate(_ expression: ArithmeticExpression) -> Int {
    // 这里已经有自完备性了。
    
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
// 这里直接使用递归函数进行求值
print(evaluate(product))
















