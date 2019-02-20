//
//  main.swift
//  StringAndCharacters
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

//多行字符串字面量
//由一对三个双引号包裹的文本字符集。这个字符集从开启引号之后的第一行开始
//这里可以使用（\）作为续航符、这里不会出现换行的情况
//这里会忽略源代码缩进。
let softWrappedQuotation = """
    The White Rabbit put on his spectacles.  "Where shall I begin, \
    please your Majesty?" he asked.

        "Begin at the beginning," the King said gravely, "and go on \
    till you come to the end; then stop."
    """
print(softWrappedQuotation)

//转义字符
let threeDoubleQuotes = """
Escaping the first quote \"""
Escaping all three quotes \"\"\"
"""
print(threeDoubleQuotes)

//初始化空字符串

var emptyString = ""    //空字符串字面量
var anotherEmptyString = String()   //初始化方法
//两个字符串均为空、并等价。

//字符串判空操作
if emptyString.isEmpty {
    print("Nothing to see here")
}

//字符串可变性
var variableString = "Horse"
variableString += " and carriage"
// variableString 现在为 "Horse and carriage"

//let constantString = "Highlander"
//constantString += " and another Highlander"
// 这会报告一个编译错误 (compile-time error) - 常量字符串不可以被修改。

//字符串是值类型
//任何情况下，都会对已有字符串值创建新副本，并对该新副本传值或赋值操作。
//可以使用for-in进行循环字符串
//字符
for character in "Dog!🐶" {
    print(character)
}

//可以使用 字符 类型 并用字符字面量进行赋值

let exclamationMark: Character = "!"
print(exclamationMark)

//可以通过值类型为字符的数组初始化
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString) // Prints "Cat!🐱"

//连接字符串和字符
//1、通过 + 号
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
print(welcome)
// welcome 现在等于 "hello there"

//也可以使用 +=
var instruction = "look over"
instruction += string2
// instruction 现在等于 "look over there"

//也可以使用append()
let exclamationMark1: Character = "!"
welcome.append(exclamationMark1)
// welcome 现在等于 "hello there!"

//You can’t append a String or Character to an existing Character variable, because a Character value must contain a single character only.
//不能添加字符串或者字符到 字符变量， 因为字符变量只包含一个字符。
//var exclamationMark2: Character = "!"
//exclamationMark2 += "a" //这里报错 You can’t append a String or Character to an existing Character variable, because a Character value must contain a single character only.

//多行字符串拼接
let badStart = """
one
two
"""
let end = """
three
"""
print(badStart + end)
// 打印两行:这里不会主动包含换行符
// one
// twothree

let goodStart = """
one
two\n
"""
print(goodStart + end)
// 打印三行:
// one
// two
// three


//字符串插值
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message is "3 times 2.5 is 7.5"
print(message)

//Unicode
//可扩展字形群集
//每个字符类型代表一个可扩展的字形群

let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e 后面加上
print("\(eAcute):\(combinedEAcute)")
// eAcute 是 é, combinedEAcute 是 é

//韩文
let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
// precomposed 是 한, decomposed 是 한
print("\(precomposed):\(decomposed)")


let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute 是 é⃝
print("\(enclosedEAcute)")

let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters")
// 打印输出 "unusualMenagerie has 40 characters"

//使用可拓展字符群集，并不一定会更改字符串的字符数
let unusualMenagerie1 = "🐨🐌🐧🐪"
print("unusualMenagerie has \(unusualMenagerie1.count) characters")
// 打印输出 "unusualMenagerie has 4 characters"

var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
// 打印输出 "the number of characters in cafe is 4"

word += "\u{301}"    // 拼接一个重音，U+0301

//这里拼接重音并不会增加字符个数
print("the number of characters in \(word) is \(word.count) length:\(word.utf16.count)")
// 打印输出 "the number of characters in café is 4"

//访问和修改字符串

//字符串索引
let greeting = "Guten Tag!"
//这是一个特殊的类型，用于标记字符串下标
let star: String.Index = greeting.startIndex
print(greeting[star], star)   //  G Index(_compoundOffset: 0, _cache: Swift.String.Index._Cache.utf16)

print(greeting[greeting.index(before: greeting.endIndex)])  //  !

print(greeting[greeting.index(after: greeting.startIndex)]) // u

let index = greeting.index(greeting.startIndex, offsetBy: 7)
print(greeting[index])  // a

//试图获取越界索引对应的 字符 ， 将发生一个运行时错误
//这里和数组是一致的。
//greeting[greeting.endIndex] // error  运行时错误
//greeting.index(after: greeting.endIndex) // error  运行时错误

//使用 indices 会创建要给包含全部索引的范围

for index in greeting.indices {
    print("\(greeting[index])")
}
// 打印输出 "G u t e n   T a g ! "

//插入和删除
var welcome1 = "hello"
welcome1.insert(contentsOf: "!", at: welcome1.endIndex)
print(welcome1) //welcome 变量现在等于 "hello!"

welcome1.insert(contentsOf: "there", at: welcome1.index(before: welcome1.endIndex))
print(welcome1) //welcom 变量现在等于 "hello there!"

//这里是数组越界
//welcome1.remove(at: welcome1.endIndex)
//print(welcome1)

welcome1.remove(at: welcome1.index(before: welcome1.endIndex))
print(welcome1)
// welcome 现在等于 "hello there"

//这个是一个range类型
let range = welcome1.index(welcome1.endIndex, offsetBy: -5)..<welcome1.endIndex
welcome1.removeSubrange(range)
print(welcome1)
// welcome 现在等于 "hello"


//子字符串

let greeting1 = "Hello, world!"
let index1 = greeting1.index(of: ",") ?? greeting1.endIndex
let beginning = greeting1[..<index1]
// beginning 的值为 "Hello"
print(beginning)

// 把结果转化为 String 以便长期存储。
// 这里是为了更好的内存优化
let newString = String(beginning)
print(newString)

// 比较字符串
// 使用比较运算符 ==   !=

let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}
// 打印输出 "These two strings are considered equal"



//字形群集是标准相等的，那么就认为是相等的。

// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

 //这里是 20 和 21 ,但是他们依然相等
print(eAcuteQuestion.utf16.count, combinedEAcuteQuestion.utf16.count)

if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}
// 打印输出 "These two strings are considered equal"

let latinCapitalLetterA: Character = "\u{41}" // 英语中的A

let cyrillicCapitalLetterA: Character = "\u{0410}"  //俄语中A

//这里是不同的语言意义， 比如 日（太阳） 日 (other）
if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent")
}
print(latinCapitalLetterA, cyrillicCapitalLetterA)
// 打印 "These two characters are not equivalent"


// MARK: 前后缀相等比较
// 方法都是逐字符进行比较的
//数组
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
//这里是前缀比较、这里返回 Bool 类型
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")
// 打印输出 "There are 5 scenes in Act 1"

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// 打印输出 "6 mansion scenes; 2 cell scenes"

// MARK: 字符串的Unicode表示形式
// UTF16View是无符号16位（UInt16）值的集合
let dogString = "Dog‼🐶狗"
for character in dogString {
    print("\(character) ", terminator: "")
}
print("")
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print()
// 68 111 103 226 128 188 240 159 144 182
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")
// 68 111 103 8252 55357 56374

// Unicode 标量表示
//您可以通过遍历String值的unicodeScalars属性来访问它的 Unicode 标量表示。 其为UnicodeScalarView类型的属性，UnicodeScalarView是UnicodeScalar类型的值的集合。 UnicodeScalar是21位的 Unicode 代码点。

for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")
// 68 111 103 8252 128054


for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}
// D
// o
// g
// ‼
// 🐶

let interpolationScalar = "This is test:\(dogString.unicodeScalars)"
print(interpolationScalar)
