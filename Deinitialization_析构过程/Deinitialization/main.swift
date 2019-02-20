//
//  main.swift
//  Deinitialization
//
//  Created by mac on 2018/4/20.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 析构器是在实例释放发生前被自动调用的。你不能主动调用析构器。子类继承了父类的析构器。并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器。父类的析构器也同样会被调用。
//因为直到实例的析构器被调用后，实例才会被释放，所以析构器可以访问实例的所有属性，并且可以根据那些属性可以修改它的行为（比如查找一个需要被关闭的文件）。

class Bank {
    // 类型属性
    static var coinsInBank = 10000
    // 类型方法
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        //
        coinsInPurse = Bank.distribute(coins: coins)
    }
    
    func win(coins: Int) -> Void {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// 打印 "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// 打印 "There are now 9900 coins left in the bank"

playerOne?.win(coins: 2000)

print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// 输出 "PlayerOne won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left")
// 输出 "The bank now only has 7900 coins left"

playerOne = nil
print("PlayerOne has left the game")
// 打印 "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// 打印 "The bank now has 10000 coins"









