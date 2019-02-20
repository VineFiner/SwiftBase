//
//  main.swift
//  AdvancedOperators
//
//  Created by mac on 2018/4/23.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 高级运算符

// MARK: 位运算符

// 位运算符可以操作数据结构图中每个独立的比特位。他们通常用在底层开发中，比如图形编程和创建设备驱动。
// 位运算符在处理外部资源的原始数据时也十分有用，比如对自定义通信协议传输的数据进行编码和解码

// 按位取反运算符
// 按位取反运算符是要给前缀运算符，需要直接放在运算的数之前，并且他们之间不能添加任何空格
let initialBits: UInt8 = 0b00001111
let tinvertedBits = ~initialBits

print(String(initialBits))

// 按位与运算符
// 按位与运算符 & 可以对两个数的比特位进行合并。他返回一个新的数，只有当两个数的对应为都为 1 的时候， 新数的对应为才是 1

let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits // 等于 00111100

// 按位或运算符
// 按位或运算符 | 可以对两个数的 比特位进行比较。他返回一个新的数，只要连个数的UI应为中有任意一个为 1 新数的值的对应为就是1

let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits // 等于 11111110

// 按位异或运算符
// 按位异或运算符 ^ 可以对两个数的比特位进行比较。他返回一个新的数。当着连个数的对应位不相同时，新数的对应位就为 1

let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits // 等于 00010001

// 按位左移、右移运算符
//按位左移运算符（<<）和按位右移运算符（>>）可以对一个数的所有位进行指定位数的左移和右移，但是需要遵守下面定义的规则。
//对一个数进行按位左移或按位右移，相当于对这个数进行乘以 2 或除以 2 的运算。将一个整数左移一位，等价于将这个数乘以 2，同样地，将一个整数右移一位，等价于将这个数除以 2。

/*
 无符号整数的移位运算
 
 对无符号整数进行移位的规则如下：
 
 已经存在的位按指定的位数进行左移和右移。
 任何因移动而超出整型存储范围的位都会被丢弃。
 用 0 来填充移位后产生的空白位。

 */




// MARK: 溢出运算符

// 默认情况下，当像一个整数赋予超过他容量的值时，Swift默认会报错，而不是生成一个无效的数。这个行为为我们在运算过大或者过小的数的时候提供了额外的安全性。
var potentialOverflow = Int16.max
// potentialOverflow 的值是 32767，这是 Int16 能容纳的最大整数
//potentialOverflow += 1
// 这里会报错

/*
 
 然而，也可以选择让系统在数值溢出的时候采取截断处理，而非报错。可以使用 Swift 提供的三个溢出运算符来让系统支持整数溢出运算。这些运算符都是以 & 开头的：
 
 溢出加法 &+
 溢出减法 &-
 溢出乘法 &*
 
 */

var signedOverflow = Int8.min
// signedOverflow 等于 Int8 所能容纳的最小整数 -128
signedOverflow = signedOverflow &- 1
// 此时 signedOverflow 等于 127

// MARK: 优先级和结合性
/*
 运算符的优先级使得一些运算符优先于其他运算符，高优先级的运算符会先被计算。
 
 结合性定义了相同优先级的运算符是如何结合的，也就是说，是与左边结合为一组，还是与右边结合为一组。可以将这意思理解为“它们是与左边的表达式结合的”或者“它们是与右边的表达式结合的”。
 */


// MARK: 运算符函数
// 类和结构体可以为现有的运算符提供自定义的实现，这通常被称为运算符重载
// 加法运算符， 是一个双目运算符，同时还是一个中缀运算符。

struct Vector2D {
    var x = 0.0, y = 0.0
}
extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
print(combinedVector)

// 前缀和后缀运算符

/*
 上个例子演示了一个双目中缀运算符的自定义实现。类与结构体也能提供标准单目运算符的实现。单目运算符只运算一个值。当运算符出现在值之前时，它就是前缀的（例如 -a），而当它出现在值之后时，它就是后缀的（例如 b!）。
 
 要实现前缀或者后缀运算符，需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 修饰符：
 */

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
// negative 是一个值为 (-3.0, -4.0) 的 Vector2D 实例
let alsoPositive = -negative
// alsoPositive 是一个值为 (3.0, 4.0) 的 Vector2D 实例

// 复合赋值运算符

//复合赋值运算符将赋值运算符（=）与其它运算符进行结合。例如，将加法与赋值结合成加法赋值运算符（+=）。在实现的时候，需要把运算符的左参数设置成 inout 类型，因为这个参数的值会在运算符函数内直接被修改。

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

// 不能对默认的赋值运算符（=）进行重载。只有组合赋值运算符可以被重载。同样地，也无法对三目条件运算符 （a ? b : c） 进行重载。

// 等价运算符
extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
//    实现“不等”运算符（!=），它简单地将“相等”运算符的结果进行取反后返回。
    static func != (left: Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
}
// MARK: 自定义运算符

//除了实现标准运算符，在 Swift 中还可以声明和实现自定义运算符。可以用来自定义运算符的字符列表请参考运算符。

//新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix 或者 postfix 修饰符：
// 全局定义一个运算符
// 这是为了指出这个是一个运算符
prefix operator +++

extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled 现在的值为 (2.0, 8.0)
// afterDoubling 现在的值也为 (2.0, 8.0)

//而没有明确放入优先级组的自定义中缀运算符会放到一个默认的优先级组内，其优先级高于三元运算符。
//当定义前缀与后缀运算符的时候，我们并没有指定优先级。然而，如果对同一个值同时使用前缀与后缀运算符，则后缀运算符会先参与运算。
infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
// plusMinusVector 是一个 Vector2D 实例，并且它的值为 (4.0, -2.0)
