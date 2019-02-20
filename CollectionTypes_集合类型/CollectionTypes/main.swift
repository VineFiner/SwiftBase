//
//  main.swift
//  CollectionTypes
//
//  Created by mac on 2018/4/12.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

OCCollectionTypes.test()

print("Hello, World!")

// MARK: 数组
// 数组使用有序列表存储同一类型的多个值。相同的值可以多次出现在一个数组的不同位置
// 数组应该遵循 Array<Element> 的形式, 也可以使用 [Element]

var oneInts = Array<Int>()
//oneInts.append("String") //error Cannot convert value of type 'String' to expected argument type 'Int'
//var oneInts1 = Array()  // error Generic parameter 'Element' could not be inferred
print(oneInts)

var twoInts: [Int] = []
// 给定类型之后，我们可以设置为空数组，但是它的类型依然是 [Int]类型
print(twoInts)

var someInts = [Int]()
//var someInts1 = []  // error Empty collection literal requires an explicit type
print("someInts is of type \("[Int]") with \(someInts.count) items.")
// 打印 "someInts is of type [Int] with 0 items."

someInts.append(3)
// someInts 现在包含一个 Int 值
print(someInts)
someInts = []
// someInts 现在是空数组，但是仍然是 [Int] 类型的。
print(someInts)

someInts += [Int](arrayLiteral: 1, 2, 3)
print(someInts)
//创建一个带有默认值的数组
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]
print(threeDoubles)

//通过两个数组相加创建一个数组
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles 被推断为 [Double]，等价于 [2.5, 2.5, 2.5]

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles 被推断为 [Double]，等价于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
print(sixDoubles)

var anotherThreeDoubles1 = Array(repeating: "Str", count: 3)

//var sixDoubles1 = threeDoubles + anotherThreeDoubles1 // error Type of expression is ambiguous without more context
//用数组字面量构造数组
var shoppingList: [String] = ["Eggs", "Milk"]
// or
var shoppingList1 = ["Eggs", "Milk"]
// shoppingList 已经被构造并且拥有两个初始项。

// MARK: 访问和修改数组

// 只读属性 count
print("The shopping list contains \(shoppingList.count) items.")
// 输出 "The shopping list contains 2 items."（这个数组有2个项）

// 使用bool类型判空
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}
// 打印 "The shopping list is not empty."（shoppinglist 不是空的）

// 添加新数据
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
// shoppingList 现在有四项了
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList 现在有七项了

// 可以使用下标语法获取数组中的数据
var firstItem = shoppingList[0]
// 第一项是 "Eggs"

// 替换
shoppingList[0] = "Six eggs"
// 其中的第一项现在是 "Six eggs" 而不是 "Eggs"

// 多值替换
shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList 现在有6项
print(shoppingList.count, shoppingList[6...])
// 6 []
//因为数组是以nil结尾这里我们可以使用[6...]
shoppingList[6...] = ["add1", "add2"]
print(shoppingList.count, shoppingList)

shoppingList.insert("Maple Syrup", at: 0)
// shoppingList 现在有7项
// "Maple Syrup" 现在是这个列表中的第一项
print(shoppingList)

//shoppingList.remove(at: shoppingList.count) //这里数组越界，运行时错误

let mapleSyrup = shoppingList.remove(at: 0)
// 索引值为0的数据项被移除
// shoppingList 现在只有6项，而且不包括 Maple Syrup
// mapleSyrup 常量的值等于被移除数据项的值 "Maple Syrup"
print(mapleSyrup)

let apples = shoppingList.removeLast()
// 数组的最后一项被移除了
// shoppingList 现在只有5项，不包括 Apples
// apples 常量的值现在等于 "Apples" 字符串
print(apples, shoppingList)

// MARK: 数组的遍历
// for-in

for item in shoppingList {
    print(item)
}
// Six eggs
// Milk
// Flour
// Baking Powder
// Bananas

// 如果需要索引 使用 enumerated（）

for (index, value) in shoppingList.enumerated() {
    print("Item \(String(index + 1)): \(value)")
}

// Item 1: Six eggs
// Item 2: Milk
// Item 3: Flour
// Item 4: Baking Powder
// Item 5: Bananas

//C-style for statement has been removed in Swift 3
//for let i = 0 ; i < 10; i++ {
//
//}

// MARK:  集合
// 集合类型必须是可哈希化的。
// 符合哈希协议的类型需要提供一个类型为Int的可读属性hashValue

//  == 必须满足下面三种情况
// 1、 自反性   2、对称性   3、传递性

// Swift 中的Set类型被写为 Set<Element> , 集合没有等价的简化形式
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
// 打印 "letters is of type Set<Character> with 0 items."
letters.insert("a")
// letters 现在含有1个 Character 类型的值
letters = []
// letters 现在是一个空的 Set, 但是它依然是 Set<Character> 类型

// 集合可以使用数组字面量创建集合
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
// favoriteGenres 被构造成含有三个初始值的集合
var favoriteGenres1: Set = ["Rock", "Classical", "Hip hop"]

// 下标访问集合
print("I have \(favoriteGenres.count) favorite music genres.")
// 打印 "I have 3 favorite music genres."

// 判空
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
// 打印 "I have particular music preferences."
favoriteGenres.insert("Jazz")
// favoriteGenres 现在包含4个元素

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}
// 打印 "Rock? I'm over it."

// 是否包含特定的值
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
// 打印 "It's too funky in here."

// 遍历集合
for genre in favoriteGenres {
    print("\(genre)")
}
// Classical
// Jazz
// Hip hop

// 排序之后遍历
for genre in favoriteGenres.sorted() {
    print("\(genre)")
}
// prints "Classical"
// prints "Hip hop"
// prints "Jazz

// 集合交集并集
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

let union = oddDigits.union(evenDigits).sorted()
print("并集", union)
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
let intersection = oddDigits.intersection(evenDigits).sorted()
print("交集", intersection)
// []
let subtracting = oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
print("减去交集", subtracting)
// [1, 9]
let symmetricDifference = oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
print("并集减去交集", symmetricDifference)
// [1, 2, 9]

//使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
//使用isSubset(of:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
//使用isSuperset(of:)方法来判断一个集合中包含另一个集合中所有的值。
//使用isStrictSubset(of:)或者isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
//使用isDisjoint(with:)方法来判断两个集合是否不含有相同的值(是否没有交集)。
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

let isSubset = houseAnimals.isSubset(of: farmAnimals)
print(isSubset)
// true
let isSuperset = farmAnimals.isSuperset(of: houseAnimals)
print(isSuperset)
// true
let isDisjoint = farmAnimals.isDisjoint(with: cityAnimals)
print(isDisjoint)

// MARK: 字典
// 相同类型的值的容器
// 字典使用 Dictionary<key, Value>定义 Key必须遵从哈希协议 可以简写为[key, Value]

var namesOfIntegers = [Int: String]()
// namesOfIntegers 是一个空的 [Int: String] 字典

// 已经提供了类型信息，这里我们可以创建一个空字典
namesOfIntegers[16] = "sixteen"
// namesOfIntegers 现在包含一个键值对
namesOfIntegers = [:]
// namesOfIntegers 又成为了一个 [Int: String] 类型的空字典

// 使用字面量进行创建字典
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
print(airports)

//可以写为
var airports1 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// 下标访问
print("The dictionary of airports contains \(airports.count) items.")
// 打印 "The dictionary of airports contains 2 items."（这个字典有两个数据项）

// 判空
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}
// 打印 "The airports dictionary is not empty."

//没有这个键值、这里是直接添加。
airports["LHR"] = "London"
// airports 字典现在有三个数据项

// 如果有这个键值、这里是修改
airports["LHR"] = "London Heathrow"
// "LHR"对应的值 被改为 "London Heathrow

// 这里可以帮助我们检查是否更新成功
// 如果有旧值会返回旧值， 没有旧值返回nil
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// 输出 "The old value for DUB was Dublin."

// 这里取值是可选值，取值
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}
// 打印 "The name of the airport is Dublin Airport."


// 移除键值对
airports["APL"] = "Apple Internation"
// "Apple Internation" 不是真的 APL 机场，删除它
airports["APL"] = nil
// APL 现在被移除了

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}
// prints "The removed airport's name is Dublin Airport."


// 字典遍历

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
// YYZ: Toronto Pearson
// LHR: London Heathrow


for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: YYZ
// Airport code: LHR

for airportName in airports.values {
    print("Airport name: \(airportName)")
}
// Airport name: Toronto Pearson
// Airport name: London Heathrow


let airportCodes = [String](airports.keys)
// airportCodes 是 ["YYZ", "LHR"]

let airportNames = [String](airports.values)
// airportNames 是 ["Toronto Pearson", "London Heathrow"]

let testKeys =  Array(airports.keys)
print(testKeys)
