//
//  main.swift
//  Extensions
//
//  Created by mac on 2018/4/23.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 扩展就是为了一个已有的类、结构体、枚举类型或者协议类型添加新功能。
// 这包括在没有权限获取原始源代码的情况下扩展类型的能力。
// Swift的扩展没有名字

// Swift中的扩展可以

/*
 1、添加计算属性和计算型类型属性
 2、定义实例方法和类型方法
 3、提供新的构造器
 4、定义下标
 5、定义和使用新的嵌套类型
 6、使一个已有类型符合某个协议
 */

// 在Swift中，你甚至可以对协议进行扩展，提供协议要求的实现，或者添加额外的功能，从而可以让符合协议的类型拥有这些方法
// 扩展可以为一个类型添加新的功能，但是不能重写已有的功能。

// 扩展语法     使用关键字 extension来声明扩展

// 可以通过扩展要给已有的类型，使其采纳一个或多个协议。
// 如果你通过一个已有类型添加新功能，那么新功能对该实例的所有已有实例都是可用的，即使他们是在这个扩展定义之前创建的。

// 计算型属性
extension Double {
    var km: Double {
        return self * 1_000.0
    }
    var m: Double {
        return self
    }
    var cm: Double {
        return self / 100.0
    }
    var mm: Double {
        return self / 1000
    }
    var ft: Double {
        return self / 3.28084
    }
}

// 这里是计算属性
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// 打印 “One inch is 0.0254 meters”
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// 打印 “Three feet is 0.914399970739201 meters”

let aMarathon = 42.km + 195.0.m

print("A marathon is \(aMarathon) meters long")
// 打印 “A marathon is 42195.0 meters long”
// 这里是以M为基础单位的

// 扩展可以添加新的计算型属性，但是不可以添加存储型属性。
// 也不可以为已有属性添加属性观察器

// MARK: 构造器

// 扩展可以为已有类型添加新的构造器。这可以让你扩展其他类型，将你自己的定制类型作为其构造器参数。
// 或者提供该类型的原始实现中未提供的额外初始化选项

// 扩展能为类添加新的便利构造器，但是他们不能为类添加新的指定构造器或析构器。指定构造器和析构器必须总是由原始的类实现来提供。
// 如果你使用扩展为一个值类型添加构造器，同时该值类型的原始实现中未定义任何定制的构造器且所有存储属性提供了默认值。
// 那么我们就可以在扩展中的构造器里调用默认构造器和逐一成员构造器。
// 如果你把定制的构造器写在值类型的原始实现中，上述规则将不再使用。

struct Size {
    var width = 0.0
    var height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

// 这里我们可以提供一个额外的接受指定中心点和大小的构造器来扩展Rect结构体
extension Rect {
    // 理论上不能添加指定构造器
    // 如果原始实现中未定义任何构造器且所有存储属性提供了默认值。
    // 那么我们就可以在扩展中的构造器里调用默认构造器和逐一成员构造器
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
print(centerRect)
// centerRect 的原点是 (2.5, 2.5)，大小是 (3.0, 3.0)
// 如果你使用扩展提供了一个新的构造器，你依旧有责任确保构造过程能够让实例完全初始化。

// MARK: 方法扩展
// 扩展可以为已有类型添加新的实例方法和类型方法。
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
3.repetitions(task: {
    print("Hello")
})

// 使用尾随闭包
3.repetitions {
    print("Goodbye")
}

// 可变实例方法
// 通过扩展添加的实例方法也可以修改该实例本身。结构体和枚举类型中修改 self 或其属性的方法必须将该实例方法标注为
// 如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating)行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的self属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
// mutating

extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()
print(someInt)

// 下标

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0 ..< digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) & 10
    }
}

print(2332342342[3])

// 嵌套类型
// 扩展可以为已有的类、结构体、枚举添加新的嵌套类型
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        // 这里的where是额外条件
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])








