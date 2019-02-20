//
//  main.swift
//  Properties
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 属性
// MAKR: 存储属性
// 属性将值跟特定的类，结构体或枚举关联。存储属性存储常量或变脸工作位实例的一部分。
// 计算属性计算一个值。
// 计算属性可用于  类、结构体、枚举
// 存储属性只能用于 类、结构体

// 存储属性和计算属性通常与特定类型的实例关联。但是属性也可以直接作用于类型本身。这种属性称为类型属性。
// 可以定义属性观察器来监控属性值的变化，以此来除法一个自定义的操作。属性观察器可以添加到自己定义的存储属性删个，也可以添加到父类继承的属性上。

// MARK:存储属性

// 结构体有逐一构造器
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// 该区间表示整数0，1，2
rangeOfThreeItems.firstValue = 6
// 该区间现在表示整数6，7，8
//FixedLengthRange 的实例包含一个名为 firstValue 的变量存储属性和一个名为 length 的常量存储属性。在上面的例子中，length 在创建实例的时候被初始化，因为它是一个常量存储属性，所以之后无法修改它的值。

//如果创建了一个结构体的实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使有属性被声明为变量也不行：
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// 该区间表示整数0，1，2，3
//rangeOfFourItems.firstValue = 6
// 尽管 firstValue 是个变量属性，这里还是会报错

//因为 rangeOfFourItems 被声明成了常量（用 let 关键字），即使 firstValue 是一个变量属性，也无法再修改它了。
//这种行为是由于结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
//属于引用类型的类（class）则不一样。把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属性。

// 延时存储属性
// 延时存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用lazy来表示一个延时存储属性
// 这里必须将延时存储属性声明成变量。

class DataImporter {
    /*
     DataImporter 是一个负责将外部文件中的数据导入的类。
     这个类的初始化会消耗不少时间。
     */
    var fileName = "data.txt"
    // 这里会提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // 这里会提供数据管理功能
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// DataImporter 实例的 importer 属性还没有被创建

print(manager.importer.fileName)
// DataImporter 实例的 importer 属性现在被创建了
// 输出 “data.txt"
// 如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。

// MARK: 存储属性和实例变量

// Swift 中同意使用属性来实现，都在唯一一个地方（类型定义中）定义

// MARK: 计算属性

// 除存储属性外，类，结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个getter和一个可选的setter，来间接获取和设置其他属性或变量的值。
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"

// 这个例子定义了 3 个结构体来描述几何形状

// 如果计算属性的setter没有定义表示新值的参数名，则可以使用默认名称 newValue

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// 只读计算属性
// 只能使用 var 关键字来定义计算属性。

// 只读计算属性的声明可以去掉 get 关键字和花括号
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

// 属性观察器
// 属性观察器监控和响应属性值的变化， 每次属性被设置值的时候都会调用属性观察器，
// 即使新值和当前值相同的时候也不例外

// Tip: 注意 父类的属性在子类的构造器中被赋值时，它在父类中的 willSet 和 didSet 观察器会被调用，随后才会调用子类的观察器。在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用。 有关构造器代理的更多信息，请参考值类型的构造器代理和类的构造器代理规则。

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps

// 即使新旧值一致，也是会触发的。
// 如果将属性通过 in-out 方式传入函数。 willset 和 didset 也是会调用的。
// 在函数内部使用的是参数的copy，函数结束后，又对参数重新赋值。

// MARK: 全局变量和局部变量

// 全局变量是 任何类型外定义的变量
// 局部变量是 内部定义的变量

// 全局变量或常量都是延时计算的，但是不需要标记lazy。局部范围的常量或变量从不延迟计算。

// MARK: 类型属性

// 实例之间的属性相互独立
// 类型属性、只有唯一的一份。

// 必须给存储型类型属性指定默认值

// MAKR: 类型属性语法
// 类型属性是作为类型定义的一部分卸载类型最外层的花括号内的。因此他的作用范围也就在类型支持的范围内。

// 使用关键字 static 来定义类型属性

struct SomeStructure {
    // 这里是存储属性、类型属性
    static var storedTypeProperty = "Some value."
    // 这里是计算属性、类型属性
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}


// 可以改用关键字 class 来支持子类对父类的实现进行重写
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
// 实例属性

// 获取和设置类型属性的值
// 这里是通过类型本身点语法来访问的

print(SomeStructure.storedTypeProperty)
// 打印 "Some value"
SomeStructure.storedTypeProperty = "Another value"

print(SomeStructure.storedTypeProperty)
// 打印 “Another value”

print(SomeEnumeration.computedTypeProperty)
// print "6"

print(SomeClass.computedTypeProperty)
// print "27"

// 使用结构体
struct AudioChannel {
    static let thresholdLevel = 10 // 类型属性
    static var maxInputLevelForAllChannels = 0  // 类型属性
    var currentLevel: Int = 0 {
        // 这里是属性观察器
//        willSet {
//
//        }
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // 将当前音量限制在阈值之内
                currentLevel = AudioChannel.thresholdLevel
            }
            // MARK: 当第一次检查过程中， didSet 属性观察器 将 currentLevel 设置成了不同的值，但这不会造成属性观察器再次调用。
            
            if  currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // 存储当前音量作为新的最大输入音量
                AudioChannel.maxInputLevelForAllChannels = currentLevel;
            }
        }
    }
    
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// 输出 "7"
print(AudioChannel.maxInputLevelForAllChannels)
// 输出 "7"

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// 输出 "10"
print(AudioChannel.maxInputLevelForAllChannels)
// 输出 "10"



















