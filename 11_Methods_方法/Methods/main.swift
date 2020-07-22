//
//  main.swift
//  Methods
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")
// MARK:实例方法

// 方法是与某些特定类型相关联的函数。
// 类、结构体、枚举都可以定义实例方法。

// 类型方法与类型本身相关联

// 实例方法要属于某个特定类、结构体或者枚举类型实例的方法。
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        self.count = 0
    }
}

// 实例一个对象
let counter = Counter()

// 开始计数
counter.increment()
// 计数值是1
print(counter.count, "开始计数")
counter.increment(by: 5)
print(counter.count, "计数值是6")
// 计数值是6
print(counter.reset())
// 计数值是 0

// Tip: self 属性， 每个实例都有一个隐含属性叫做self，self完全等同于该实例本身。
// 可以在实例的实例方法中使用这个隐含的self属性来引用当前实例

// 当某个参数名称和实例的某个属性名称相同的时候，参数名称享有优先权。

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(_ x: Double) -> Bool {
//        return x > x    // 如果不适用self前缀， Swift就认为两次使用的X都指的是名称为x的函数参数
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("This point is to the right of the line where x == 1.0")
}



// 实例方法中修改值类型
// 默认情况下、值类型的属性不能在他的实例方法中被修改
// 使用关键字 mutating 修改

struct OnePoint {
    var x = 0.0, y = 0.0
    mutating func moveByX(_ deltaX: Double, y deltaY: Double) {
        x += deltaX
        self.y += deltaY
    }
}

var somePoint1 = OnePoint(x: 1.0, y: 1.0)
// 这里是修改这个点，而不是返回一个点。
somePoint1.moveByX(2.0, y: 3.0)

print("The point is now at (\(somePoint1.x), \(somePoint1.y))")
// 打印 "The point is now at (3.0, 4.0)"

// 值类型的常量是不能进行修改的
//let fixedPoint = OnePoint(x: 3.0, y: 3.0)
//fixedPoint.moveByX(2.0, y: 3.0)
// 这里将会报告一个错误 Cannot use mutating member on immutable value: 'fixedPoint' is a 'let' constant

// 在可变方法中给self 赋值
struct TwoPoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = TwoPoint(x: self.x + deltaX, y: y + deltaY)
    }
}

var fixedPoint = TwoPoint(x: 3.0, y: 3.0)
fixedPoint.moveBy(x: 2.0, y: 3.0)
print(fixedPoint)

// 枚举的可变方法可以把 self设置为同一枚举类型中不同的成员
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight 现在等于 .High
ovenLight.next()
// ovenLight 现在等于 .Off

//上面的例子中定义了一个三态开关的枚举。每次调用next()方法时，开关在不同的电源状态（Off，Low，High）之间循环切换

// MARK: 类型方法

//实例方法是被某个类型的实例调用的方法。你也可以定义在类型本身上调用的方法，这种方法就叫做类型方法。在方法的func关键字之前加上关键字static，来指定类型方法。类还可以用关键字class来允许子类重写父类的方法实现。
class SomeClass {
    class func someTypeMethod() {
        // 在这里实现类型方法
    }
}
SomeClass.someTypeMethod()

// self指向这个类型本身，而不是类型的某个实例。
//一个类型方法可以直接通过类型方法的名称调用本类中的其它类型方法，而无需在方法名称前面加上类型名称

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult // 这里是忽略警告
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        // 这里调用的是类型方法
        LevelTracker.unlock(level + 1)
        // 是否可以修改值类型变量
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// 打印 "highest unlocked level is now 2"

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
// 打印 "level 6 has not yet been unlocked"



