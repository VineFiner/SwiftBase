//
//  main.swift
//  ClassesAndStructures
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// MARK: 类和结构体

// MARK: 共同点

// 定义属性用于存储值
// 定义方法用于存储功能
// 定义下标操作使得可以通过下标语法来访问实例所包含的值
// 定义构造器用于生成初始化值
// 通过扩展以增加默认实现的功能
// 实现协议以提供某种标准功能。

// MARK: 类单独附加的功能

// 继承允许一个类继承另一个类的特征
// 烈性转换允许在运行时检查和解释一个类实例的类型
// 析构器允许一个类实例释放任何所被分配的资源
// 引用计数允许对一个类的多次引用

// 不同点

// 结构体总是通过被复制的方式在代码中传递、不适用引用计数。

// 定义语法

class SomeClass {
    // 这里定义类
}

class SomeStructure {
    // 这里定义结构体
}

// 在每次定义一个新类或者结构体的时候，实现上你是定义了一个新的Swift类型。因此请使用驼峰命名法。以便符合标准Swift类型的大写命名风格。
// 使用小写开头的方式为 属性 方法命名

// 分辨率
struct Resolution {
    var width = 0
    var height = 0
}

// 这是一个类
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
    let type = "音频"
}

// 类和结构体示例

// Resolution结构体 和 VideoMode 类的定义仅描述了什么是Resolution和VideoMode。但是他们并没有描述一个特定的分辨率（resolution） 或者视频模式（video mode）。为了描述一个特定的分辨率或者视频模式。我们需要生成一个他们的示例

//
let someResolution = Resolution()
let someVideoMode = VideoMode()

// 属性访问
// 通过使用点语法
print("The width of someResolution is \(someResolution.width)")
// 打印 "The width of someResolution is 0"

// 也可以访问子属性
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// 打印 "The width of someVideoMode is 0"

// 使用点语法为变量属性赋值
someVideoMode.resolution.width = 1280
//someVideoMode.type = "ad" Cannot assign to property: 'type' is a 'let' constant
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
// 打印 "The width of someVideoMode is now 1280"

// Tip: 与OC不同是， Swift允许直接设置结构体属性是子属性。

// MARK: 结构体类型的成员逐一构造器
// 所有结构体都有一个自动生成的成员逐一构造器、类实例没有默认的成员逐一构造器。
let vga = Resolution(width: 640, height: 480);


// MARK: 结构体和枚举是值类型
// 值类型被赋予给一个变量、常量，或者传递给一个函数的时候，其值会被拷贝。
// 在Swift中，所有的结构体和枚举类型都是值类型。这意味着他们的实例，以及实例中所包含的任何值类型属性
// 在代码中传递的时候都会被复制。

let hd = Resolution(width: 1920, height: 1080)
//hd.width = 30; error: Cannot assign to property: 'hd' is a 'let' constant
var cinema = hd

// 这里cinema的值事实上是hd的一个拷贝副本，而不是hd本身。
// 现在我们修改cinema
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
// 打印 "cinema is now 2048 pixels wide"

print("hd is still \(hd.width) pixels wide")
// 打印 "hd is still 1920 pixels wide"

// 这里是值拷贝所以两个互不干扰
// 枚举有相同的准则

enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}
// 打印 "The remembered direction is still .West"

// Mark: 类是引用类型

// 与值类型不同，引用类型在被赋予到一个变量、常量或者传递到一个函数时，其值不会被拷贝。
// 因此，引用的是已存在的实例本身而不是其拷贝。

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

//tenEighty = VideoMode() ; // error Cannot assign to value: 'tenEighty' is a 'let' constant

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

// 因为类是引用类型，所以tenEight 和 alsoTenEight实际上引用的相同的VideoMode实例。
// 他们是同一个实例的两种叫法

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// 打印 "The frameRate property of theEighty is now 30.0"

// Tip: 这里需要注意的是 tenEighty 和 alsoTenEighty 被声明为常量而不是变量。
// 然而你依然可以改变tenEighty.frameRate 和 alsoTenEighty.frameRate，
// 因为tenEighty 和 alsoTenEighty这两个常量的值并未改变。他们并不存储这个VideoMode实例。而仅仅是对VideoModel实例的引用。
// 所以，改变的是被引用的VideoMode和frameRate属性。而不是引用VideoMode的常量的值。


// MARK: 恒等运算符
// 因为类是引用类型，有可能有多个常量和变量在幕后同事引用同一个类实例。
// 对于结构体和枚举来说，这并不成立。因为他们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是被拷贝

// 等价于 ===  不等价于 !==

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
}
// 因为他们是引用同一个实例，所以他们等价于是成立的。
//打印 "tenEighty and alsoTenEighty refer to the same Resolution instance."

// Tip: === 和 == 是不同

//“等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
//“等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相等”来说，这是一种更加合适的叫法。

// 指针

// 使用结构体的情况

//该数据结构的主要目的是用来封装少量相关简单数据值。
//有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
//该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
//该数据结构不需要去继承另一个既有类型的属性或者行为。

/*
 注意 以上是对字符串、数组、字典的“拷贝”行为的描述。在你的代码中，拷贝行为看起来似乎总会发生。然而，Swift 在幕后只在绝对必要时才执行实际的拷贝。Swift 管理所有的值拷贝以确保性能最优化，所以你没必要去回避赋值来保证性能最优化。
 */














































