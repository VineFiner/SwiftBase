//
//  main.swift
//  MemorySafety
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// MARK:了解对内存的冲突访问

// 当你设置变量的值，或传递参数时，会发生内存访问。

// 一个写入操作
var one = 1

// 一个读取操作
print("We`re number \(one) !")

// 至少一个是写入访问
// 他们访问的是同一块内存
// 他们的访问时间重叠

// 两个即时访问
func oneMore(than number: Int) -> Int {
    return number + 1
}

var myNumber = 1

myNumber = oneMore(than: myNumber)
print(myNumber)

// 拥有长时访问的参数
// 输入输出形式的参数的访问冲突
// 输入输出参数的写入或在所有非输入输出参数计算之后开始，持续到整个函数调用结束

var stepSize = 1

func increment(_ number: inout Int) {
    // 这里是两个读取操作
//    let a = number
//    print("a-->", a)
//    let b = setpSize
//    print("b-->",b)
    // 这是一个读写操作
//    setpSize += number
    number += stepSize
}

//increment(&setpSize)


// 解决冲突
// 做一个显示拷贝

var copyOfStepSize = stepSize
increment(&copyOfStepSize)

// Update the original.
stepSize = copyOfStepSize
// stepSize is now 2
// stepSize is now 2


func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)  // OK
print("One:\(playerOneScore) Two:\(playerTwoScore)")
//balance(&playerOneScore, &playerOneScore)
// Error: conflicting accesses to playerOneScore


// 在方法中对self的访问冲突

struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // OK

//oscar.shareHealth(with: &oscar)

// 属性的访问冲突

//像是结构体、元组以及枚举这些类型都是由独立值构成，比如结构体的属性或者元组的元素。由于这些都是值类型，改变任何一个值都会改变整个类型，意味着读或者写访问到这些属性就需要对整个值进行读写访问。比如说，对元组的元素进行重叠写入访问就会产生冲突：
var playerInformation = (health: 10, energy: 20)
//balance(&playerInformation.health, &playerInformation.energy)
// Error: conflicting access to properties of playerInformation

//下面的代码显示了对全局变量结构体属性的重叠写入访问，导致同样的错误。

var holly = Player(name: "Holly", health: 10, energy: 10)
//balance(&holly.health, &holly.energy)  // Error

//实际上，大多数对结构体属性的访问可以安全的重叠。比如果，如果上边变量 holly 变成局部变量而不是全局变量，那么编译器就可以保证重叠访问结构体的存储属性是安全的：

func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)  // OK
}

//你只访问实例的存储属性，不是计算属性或者类属性；
//结构体是局部变量而非全局变量；
//结构体要么没有被闭包捕获要么只被非逃逸闭包捕获。


