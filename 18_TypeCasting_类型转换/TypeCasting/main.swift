//
//  main.swift
//  TypeCasting
//
//  Created by mac on 2018/4/23.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 类型转换
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name;
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

// 检查类型
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

// 向下转型
// 某类型的一个常量或变量可能实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到他的子类型。
// 用类型转换操作符 as? as!

// 因为向下转型可能会失败，类型转型操作符带有两种不同形式。条件形式 as？ 返回一个你试图向下转成的类型是可选值。
// 强制形式 as! 把试图向下转型和强制解包转换结果结合为一个操作。

// 转换没有针对改变实例或它的值。根本的实例保持不变；只是简单的把它作为他被转换成的类型来使用

// Any类型可以表示所有类型的值，包括可选类型。Swift会在你用Any类型来表示一个可选值的时候给你一个警告。
// 你可以使用as 操作符显式转换为Any
// 可选类型也是 Any类型

var things = [Any]()

var optionalNumber: Int? = 3
//Expression implicitly coerced from 'Int?' to Any
//Provide a default value to avoid this warning
//Force-unwrap the value to avoid this warning
//Explicitly cast to Any with 'as Any' to silence this warning

//表达式从'Int？'隐式强制转换 去任何
//提供一个默认值以避免此警告
//强制解开该值以避免此警告
//用'as Any'明确地转换为Any以使此警告消失

things.append(optionalNumber)
print(things)
optionalNumber = nil
things.append(optionalNumber)
things.append(optionalNumber as Any)

print(things)


things.append("NewValue")

print(things)

//[Optional(3), nil, nil, "NewValue"]









