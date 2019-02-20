//
//  main.swift
//  Subscripts
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

Dimension.test()
//这里是C里面的函数
test()

print("Hello, World!")

// MARK: 下标语法
// 下标允许你通过在实例名称后面的括号中传入一个或者多个索引值来对实例进行存取。
// 使用 subscript关键字

//subscript(index: Int) -> Int {
//    get {
//        // 这里返回一个适当的 Int类型的值
//        return 3
//    }
//
////    newValue的类型和下标的返回类型相同。如同计算型属性，可以不指定 setter 的参数（newValue）。如果不指定参数，setter 会提供一个名为newValue的默认参数。
//    set (newValue) {
//        // 这里执行适当的赋值操作
//    }
//}


// 如果是只读属性，可以省略下标的get 关键字
//subscript(index: Int) -> Int {
//    // 返回一个适当的 Int 类型的值
//     return 3
//}

// 只读下标
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index ;
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

// MARK: 下标用法

//注意 Swift 的Dictionary类型的下标接受并返回可选类型的值。上例中的numberOfLegs字典通过下标返回的是一个Int?或者说“可选的int”。Dictionary类型之所以如此实现下标，是因为不是每个键都有个对应的值，同时这也提供了一种通过键删除对应值的方式，只需将键对应的值赋值为nil即可。

//Mark: 下标选项
// 下标可以接受任一数量的入参，并且这些入参可以使任一类型。下标的返回值也可以是任意类型。
// 下标可以使用变量参数和可变参数，但是不能使用输入输出参数，也不能给参数设置默认值。

// 多个入参的下标实现
// 矩阵、行、列、网格

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    // 初始化
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        // 这里self可以省略
        self.grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    // 这个函数用来检查入参是否合法
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    // 相当于一个方法，但是可以使用下标的形式进行访问。
    
    // 现在定义下标
    subscript(row: Int, column: Int) -> Double {
        get {
            // 这里是断点
            assert(indexIsValid(row: row, column: column), "Index out of range")
            
            return grid[(row * self.columns) + column]
        }
        
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

// 现在我们使用这个矩阵
var matrix = Matrix(rows: 2, columns: 2)
// 现在是一个 2 * 2 矩阵

matrix[0, 1] = 1.5
matrix[1, 0] = 3.2


//let someValue = matrix[2, 2]
// 断言将会触发，因为 [2, 2] 已经超过了 matrix 的范围


// 二维数组

var array1 = Array<Array<Int>>()

// 一般我们使用以下方法
// 它的类型是 [[]]
var array = [[Int]]()

// 现在进行赋值
array = [
    [1, 2, 3, 4],
    [5, 6, 7, 8]
]

//array.append(<#T##newElement: [Int]##[Int]#>)
array.append([9, 10, 11])

//数组遍历

for row in array {
    for index in row {
        print(index)
    }
}

//循环重新设置
for _ in 1...9 {
    var row = [Int]()
    for _ in 1...7 {
        row.append(0)
    }
    array.append(row)
}

for row in array {
    for index in row {
        print(index)
    }
}

print("\n\n\nThis is dynamic \n")
// 基础使用
//@dynamicMemberLookup
//struct Titan {
//    subscript(dynamicMember member: String) -> String {
//        let properties = ["name": "Titanjun",
//                          "city": "Hang"]
//        return properties[member, default: "0"]
//    }
//}
//
//let titan = Titan()
//print("name:\(titan.name) city:\(titan.city) age:\(titan.age)")


@dynamicMemberLookup
struct Titan {
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Titanjun",
                          "city": "Hang"]
        return properties[member, default: "默认：0"]
    }
    subscript(dynamicMember member: String) -> Int {
        let properties = ["age": 20, "source": 99]
        return properties[member, default: 0] //默认值
    }
}
// 这里需要注明取得的类型
let titan = Titan()
let name: String = titan.name
let city: String = titan.city
let age: Int = titan.age
var jun: String = titan.jun

print(jun)
jun = "?"
print(jun)
print("name = \(name), city = \(city), age = \(age)")

// 返回函数

