//
//  main.swift
//  ErrorHandling
//
//  Created by mac on 2018/4/20.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 可选类型可用来表示值缺失。

// 表示并抛出错误

// Swift中， 错误用符合Error协议的类型值来表示。这个空协议表明该类型可以用于错误处理。

// 实际上 VendingMachineError已经是一种确定的类型

//enum VendingMachineError {
//    case invalidSelection   // 选择无效
//    case insufficientFunds(coinsNeeded: Int)    // 金额不足
//    case outOfStock     // 缺货
//}

enum VendingMachineError: Error {
    case invalidSelection                    //选择无效
    case insufficientFunds(coinsNeeded: Int) //金额不足
    case outOfStock                          //缺货
}

// 使用关键字 throw 进行传递错误
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

//一个 throwing 函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域。
//只有 throwing 函数可以传递错误。任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理。
//为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数列表之后加上throws关键字。一个标有throws关键字的函数被称作throwing 函数。如果这个函数指明了返回值类型，throws关键词需要写在箭头（->）的前面。

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing\(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        //提前退出
        guard let item = inventory[name] else {
            // 对于 throw函数需要 结构体 遵从 Error
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

// 要么直接处理 要么 传递下去

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
// 函数可以进行传递错误
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

// throwing 构造器 可以像 throwing函数一样传递错误

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws{
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

// 使用 DO-Catch 处理函数
// 可以使用 do-cache语句运行一段闭包代码来处理错误

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    // 这里抛出错误
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}
// 打印 “Insufficient funds. Please insert an additional 2 coins.”

// 可选错误传递
// 可选整数类型

func someThrowingFunction() throws -> Int {
    // ...
    return 3
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

// 禁用错误传递

//有时你知道某个throwing函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写try!来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一个运行时错误。

// 指定清理操作

//可以使用defer语句在即将离开当前代码块时执行一系列语句。该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，或是由于诸如return、break的语句。例如，你可以用defer语句来确保文件描述符得以关闭，以及手动分配的内存得以释放。

//defer语句将代码的执行延迟到当前的作用域退出之前。该语句由defer关键字和要被延迟执行的语句组成。延迟执行的语句不能包含任何控制转移语句，例如break、return语句，或是抛出一个错误。延迟执行的操作会按照它们声明的顺序从后往前执行——也就是说，第一条defer语句中的代码最后才执行，第二条defer语句中的代码倒数第二个执行，以此类推。最后一条语句会第一个执行
//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            // Work with the file.
//        }
//        // close(file) is called here, at the end of the scope.
//    }
//}
























