//
//  main.swift
//  NestedTypes
//
//  Created by mac on 2018/4/23.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 枚举常被用于为特定类或结构体实现某些类型。类似地，枚举可以方便的定义工具类或结构体，
// 从而为某个复杂的类型所使用。为了时间这种功能。Swift允许你定义嵌套类型，可以在支持的类型中定义嵌套的枚举、类、结构体

struct BlackjackCard {
    
    // nested Suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    // nested Rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let theAceOfSpades = BlackjackCard(rank: BlackjackCard.Rank.ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// 打印 “theAceOfSpades: suit is ♠, value is 1 or 11”

// 引用嵌套类型
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
print("This is value:\(heartsSymbol)")















