//
//  main.swift
//  ControlFlow
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// swift控制流

// MARK: 循环

// For-In 循环

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
// Hello, Anna!
// Hello, Alex!
// Hello, Brian!
// Hello, Jack!

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
// ants have 6 legs
// spiders have 8 legs
// cats have 4 legs

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25

// 可以使用 _ 来忽略变量值
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
// 输出 "3 to the power of 10 is 59049"

// 半开区间
let minutes = 60
for tickMark in 0..<minutes {
    // 每一分钟都渲染一个刻度线（60次）, 这里不会打印 60
    print(tickMark)
}

// 按跨度进行循环
// 开区间使用
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // 每5分钟渲染一个刻度线 (0, 5, 10, 15 ... 45, 50, 55)
    print(tickMark)
}
// 闭区间使用
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 0, through: hours, by: hourInterval) {
    // 每3小时渲染一个刻度线 (0, 3, 6, 9, 12)
    print(tickMark)
}

// While 循环

// 1、while循环， 循环开始时条件判断
// 2、 repeat-while循环， 循环结束时条件判断

let finalSquare = 25

//创建一个带有默认值的数组，等价于[0, 0, 0, ....., 0] 这里是26个值
var board = [Int](repeating: 0, count: finalSquare + 1)

// 3号 向上移动到 11号
board[03] = +08;
// 14号 向下移动到 4号
board[14] = -10;

board[06] = +11;
board[09] = +09;
board[10] = +02
board[19] = -11;
board[22] = -02;
board[24] = -08
//以上是规则

// 玩家从左下角空白处编号0 开始游戏， 第一次投掷后开始进入
// 所以这里需要先判断条件， 然后进行循环

// 当前所在格数
var square = 0
// 筛子数
var diceRoll = 0

while square < finalSquare {
    // 掷筛子
    diceRoll += 1
    if 7 == diceRoll {
        diceRoll = 1
    }
    //根据点数移动
    square += diceRoll
    
    // 如果玩家还在棋盘上， 现在是否是在特殊方格
    // 当然这里也是为了防止数组越界。

    // 1、非特殊方格，不做处理。
    // 2、特殊方格，顺着梯子爬上去或者顺着蛇滑下来。
    if square < board.count {
        // 我们使用占位数组， 非特殊情况初始值是 0
        square += board[square]
    }
    // 玩家当前位置
    print("玩家当前位置", square)
}

// repeat-while 循环

var square1 = 0
var diceRoll1 = 0

// 因为第一次，不可能在特殊方格，所以先循环是可以的。
repeat {
    // 判断当前方格，是否是特殊方格
    square1 += board[square1];
    
    // 掷骰子
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // 根据点数移动
    square1 += diceRoll
    print("当前玩家位置", square1)
    
} while square < finalSquare // 这里是在循环结束之后进行判断
print("Game over!")

// MARK: 条件语句

// if 这里只判定 Bool类型数据

var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
// 输出 "It's very cold. Consider wearing a scarf."

temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// 输出 "It's not that cold. Wear a t-shirt."

temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// 输出 "It's really warm. Don't forget to wear sunscreen."

// Switch
// Switch必须是完备的。
let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}
// 输出 "The last letter of the alphabet"

//let anotherCharacter: Character = "a"
//switch anotherCharacter {
//case "a": // 无效，这个分支下面没有语句
//case "A":
//    print("The letter A")
//default:
//    print("Not the letter A")
//}
// 这段代码会报编译错误

// Swift中没有隐式贯穿

// 这里我们可以使用 ， 号来进行复合匹配
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// 输出 "The letter A

// 或者使用关键字

switch anotherCharacter {
case "a":
    fallthrough
case "A":
    print("这里使用显示贯穿", "The letter A")
default:
    print("Not the letter A")
}

// 区间匹配
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// 输出 "There are dozens of moons orbiting Saturn."

// 在元组中， 我们可以使用 _ 来匹配所有可能的值

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// 输出 "(1, 1) is inside the box"

// 允许值绑定
// 请注意，这个switch语句不包含默认分支。这是因为最后一个 case ——case let(x, y)声明了一个可以匹配余下所有值的元组。这使得switch语句已经完备了，因此不需要再书写默认分支。
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// 输出 "on the x-axis with an x value of 2"

// MARK: 特殊的Where语句
// 在 case分支的模式可以使用 where语句来判断额外的条件。不需要逗号的关键字

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// 输出 "(1, -1) is on the line x == -y"

// 复合匹配
// 这里使用逗号隔开， 匹配多种分支

let oneCharacter: Character = "e"
switch oneCharacter {
case "a", "e", "i", "o", "u":
    print("\(oneCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(oneCharacter) is a consonant")
default:
    print("\(oneCharacter) is not a vowel or a consonant")
}
// 输出 "e is a vowel"

let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

// 输出 "On an axis, 9 from the origin"

// Continue 语句
// 停止本次循环，重新开始下次循环。
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    } else {
//        puzzleOutput.append(character) // 这里是官方例子位置
    }
    // continue 结束本次循环，开始下次循环。所以这里不会被执行
    puzzleOutput.append(character)
}
print(puzzleOutput)
// 输出 "grtmndsthnklk"

// Break
// 会立即结束整个控制流的执行。break可以在switch或循环语句中使用，用来提前结束switch或循环语句。

// 循环语句中的break
// 当有break时，会立即中断该循环体的执行。然后跳转到表示循环结束的大括号后的第一行。结束所有循环。
// 当在Switch中使用break时
// 立即中断该switch代码块。
let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}
// Prints "The integer value of 三 is 3."

// 贯穿、这里区别于C语言中的Switch

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    //这里依然会执行
    description += " an integer."
}
print(description)
// 输出 "The number 5 is a prime number, and also an integer."

// 带标签的语句

let finalSquare2 = 25
var board2 = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square2 = 0
var diceRoll2 = 0

//当前方格数不等于总数、继续循环
gameLoop: while square2 != finalSquare2 {
    diceRoll2 += 1
    if diceRoll2 == 7 { diceRoll2 = 1 }
    switch square2 + diceRoll2 {
    case finalSquare2:
        // diceRoll will move us to the final square, so the game is over
        // 骰子数刚好让玩家落入第25个方格，游戏结束
        break gameLoop
//    case finalSquare2... : // 区间这样进行表示
//        print("当前数为:\(square2 + diceRoll2)")
//        continue
    case let newSquare where newSquare > finalSquare2:
        // diceRoll will move us beyond the final square, so roll again
        // 骰子数大于最终方格数，本次投掷无效。
        print("当前数为:\(square2 + diceRoll2): 现在新值为:\(newSquare)")
        continue gameLoop   // 这里没有必要，但是也没有危害。
    default:
        // this is a valid move, so find out its effect
        square2 += diceRoll2
        square2 += board2[square2]
    }
    //当前所在方格数
    print("当前所在方格数", square2)
}
print("Game over!")


// 提前退出
// 和 if语句一样， guard的执行取决于一个表达式的布尔值。
// 条件为假， 执行else从句中的代码

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        //这里为假
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
// Prints "Hello John!"
// Prints "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// Prints "Hello Jane!"
// Prints "I hope the weather is nice in Cupertino."

// 如果条件不被满足，在else分支上的代码就会被执行。这个分支必须转移控制以退出guard语句出现的代码段。它可以用控制转移语句如return,break,continue或者throw做这件事，或者调用一个不返回的方法或函数，例如fatalError()。

// API可用性检测
if #available(macOS 10.12, *) {
    
}




