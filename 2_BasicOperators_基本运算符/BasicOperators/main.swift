//
//  main.swift
//  BasicOperators
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

//运算符、Swift中只有一个三元运算符，就是三目运算符

//赋值运算符
let b = 10
var a = 5
a = b
// a 现在等于 10
print(a)

//元组进行赋值
let (x, y) = (1, 2)
print(x)

let tuples: (Int, Int) = (2, 3)
print(tuples)
print(tuples.0)

//算术运算符

//加法运算符可用于字符串拼接
let str = "hello, " + "world" //等于"hello, world
print(str)

//求余运算符 %

let remainder = 9 % 4
print(remainder)
//对负数b求余，负数b的符号会被忽略。比如 9 % 4 和 9 % -4 值是一致的。
print("\(9 % 4):\(9 % -4):\(-9 % 4):\(-9 % -4)")

//一元负号运算符
//一元正号运算符
//虽然一元正号符什么都不会改变，但当你在使用一元负号来表达负数时，你可以使用一元正号来表达正数，如此你的代码会具有对称美。

//组合赋值运算符
var e = 1
e += 2
// e 现在是 3

//表达式 a += 2 是 a = a + 2 的简写，一个组合加运算就是把加法运算和赋值运算组合成进一个运算符里，同时完成两个运算任务。

//比较运算符
//等于（a == b）
//不等于（a != b）
//大于（a > b）
//小于（a < b）
//大于等于（a >= b）
//小于等于（a <= b）

//注意： Swift 也提供恒等（===）和不恒等（!==）这两个比较符来判断两个对象是否引用同一个对象实例。更多细节在类与结构。

//每个比较运算都返回了一个标识表达式是否成立的布尔值：

//1 == 1   // true, 因为 1 等于 1
//2 != 1   // true, 因为 2 不等于 1
//2 > 1    // true, 因为 2 大于 1
//1 < 2    // true, 因为 1 小于2
//1 >= 1   // true, 因为 1 大于等于 1
//2 <= 1   // false, 因为 2 并不小于等于 1

//比较运算符多用于条件语句
let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
// 输出 "hello, world", 因为 `name` 就是等于 "world"

//如果两个元组的元素相同，且长度相同的话，元组就可以被比较。比较元组大小会按照从左到右、逐值比较的方式，直到发现有两个值不等时停止。如果所有的值都相等，那么这一对元组我们就称它们是相等的
let tuple: Bool = (5, "zebra") < (2, "apple")
print(tuple) //is false

//("blue", -1) < ("purple", 1)       // 正常，比较的结果为 true
//("blue", false) < ("purple", true) // 错误，因为 < 不能比较布尔类型


//三目运算符
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight 现在是 90

//空合运算符
var f: Int?

print(f ?? 0)
let g =  f != nil ? f! : 3
print(g)

let defaultColorName = "red"
var userDefinedColorName: String?   //默认值为 nil

//这里会对可选变量进行解包
var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 的值为空，所以 colorNameToUse 的值为 "red"

//区间运算符

//闭区间 1 到 5
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}

//半开区间 0 到 4 不包括4

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0 ..< count {
    print("第 \(i + 1) 个人叫 \(names[i])")
}

//单侧区间
for name in names[2...] {
    print(name)
}
for i in 2...count-1 {
    print("第 \(i + 1) 个人叫 \(names[i])")
}

for name in names[..<2] {
    print(name)
}
