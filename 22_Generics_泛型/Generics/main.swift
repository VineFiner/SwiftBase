//
//  main.swift
//  Generics
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// MARK: 泛型所解决的问题

// 交换两个Int 值
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporary = a
    a = b
    b = temporary
}

var someInt = 3
var anotherInt = 107

swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// 打印 “someInt is now 107, and anotherInt is now 3”

// 如果我们交换字符串 和 Double类型 需要写两个 函数

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// 这里 a 参数 和 b 参数必须类型相同

// MARK: 泛型函数

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

/*
 这个函数的泛型版本使用了占位类型名（在这里用字母 T 来表示）来代替实际类型名（例如 Int、String 或 Double）。占位类型名没有指明 T 必须是什么类型，但是它指明了 a 和 b 必须是同一类型 T，无论 T 代表什么类型。只有 swapTwoValues(_:_:) 函数在调用时，才会根据所传入的实际类型决定 T 所代表的类型。
 
 泛型函数和非泛型函数的另外一个不同之处，在于这个泛型函数名（swapTwoValues(_:_:)）后面跟着占位类型名（T），并用尖括号括起来（<T>）。这个尖括号告诉 Swift 那个 T 是 swapTwoValues(_:_:) 函数定义内的一个占位类型名，因此 Swift 不会去查找名为 T 的实际类型。
 */

// Tip: swapTwoValues(_:_:) 函数现在可以像 swapTwoInts(_:_:) 那样调用，不同的是它能接受两个任意类型的值，条件是这两个值有着相同的类型。swapTwoValues(_:_:) 函数被调用时，T 所代表的类型都会由传入的值的类型推断出来。

var someInt1 = 3
var anotherInt1 = 107
swapTwoValues(&someInt1, &anotherInt1)
print("some:\(someInt1) another:\(anotherInt1)")

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString 现在 "world", and anotherString 现在 "hello"

//func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
//    let temporaryA = a
//    a = b
//    b = temporaryA
//}
// 上面函数 T 只是占位
func mySwapTwoValues<Fuck>(_ a: inout Fuck, _ b: inout Fuck) {
    let temporaryA = a
    a = b
    b = temporaryA
}

mySwapTwoValues(&someString, &anotherString)
print("string1:\(someString) string2:\(anotherString)")
//swap(&<#T##a: T##T#>, &<#T##b: T##T#>)

// MARK: 命名类型参数

// 请始终使用大写字母开头的驼峰命名法例如：T 和 MyTypeParameter 来为类型参数命名，以表示他们是占位类型，而不是一个值
// 大多数情况下，类型参数具有一个描述性名字。 如 Array<Element> 中的 Element。
// 然而当他们之间没有，有意义的关系时，通常使用单个字母来命名。例如 T U V

// MARK: 泛型类型
// 除了泛型函数，Swift还允许你定义泛型类型。
// 这些自定义类、结构体、枚举、可以使用于任何类型。

// 当你需要一个严格的 先进先出方式来管理集合，栈都是最实用的模型。


// 现在编写一个 Int 类型的栈
struct IntStack1 {
    var items = [Int]()
    // 对于关键字 mutating 详情见 methods
    
    // 结构体是值类型、默认情况下，值类型的属性不能在它的实例方法中被修改
    // mutating 在实例方法中修改值类型
    // 然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的self属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
//    @discardableResult // 忽略返回值不会产生警告
    
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

// 现在我们创建一个泛型版本
// 函数定义内的一个 占位类型名
// 注意，Stack 基本上和 IntStack1 相同，只是用占位类型参数 Element 代替了实际的 Int 类型。这个类型参数包裹在紧随结构体名的一对尖括号里（<Element>）。
struct Stack<Element> {
    // 这里这个是泛型类型、只有传入值之后才能确定
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

/*
 Element 为待提供的类型定义了一个占位名。这种待提供的类型可以在结构体的定义中通过 Element 来引用。在这个例子中，Element 在如下三个地方被用作占位符：
 
 创建 items 属性，使用 Element 类型的空数组对其进行初始化。
 指定 push(_:) 方法的唯一参数 item 的类型必须是 Element 类型。
 指定 pop() 方法的返回值类型必须是 Element 类型。
 */

// 这里使用是和字典 集合 数组类似
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

let fromTheTop = stackOfStrings.pop()
// fromTheTop 的值为 "cuatro"，现在栈中还有 3 个字符串

// MARK: 扩展一个泛型类型

// 这里不需要提供类型参数列表

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

// 这里只是获取 topItem
if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}

// MARK: 类型约束
// 例如字典中的key必须符合Hashable协议

//这个函数有两个类型参数。第一个类型参数 T，有一个要求 T 必须是 SomeClass 子类的类型约束；第二个类型参数 U，有一个要求 U 必须符合 SomeProtocol 协议的类型约束。
//func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//    // 这里是泛型函数的函数体部分
//}

// 类型约束

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    
    //这种循环方式
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil // 这里是可选返回值
}

//用于查找特定字符串在数组中的下标
let strings = ["cat", "dog", "llama", "parakeet", "terrapin", "llama"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
// 打印 “The index of llama is 2”

// 这里我们使用泛型替换
//func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}

// 但是这里 等式比较符 == 并不适用所有的Swift 类型

// Swift 标准库中定义了一个 Equatable 协议，该协议要求任何遵循该协议的类型必须实现等式符（==）及不等符(!=)，从而能对该类型的任意两个值进行比较。所有的 Swift 标准类型自动支持 Equatable 协议。
// 这里我们规定 泛型 T 遵从 Equatable 协议 ，只要遵从这个协议，我们就可以使用 == 比较符
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex 类型为 Int?，其值为 nil，因为 9.3 不在数组中
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex 类型为 Int?，其值为 2

// MARK: 关联类型

// 相当于泛型
protocol Container {
    
    // 定义一个关联类型
    associatedtype ItemType
    
    // 这里是为了修改值类型的属性
    mutating func append(_ item: ItemType)
    var count: Int { get }
    // 下标
    subscript(i: Int) -> ItemType { get }
}

/*
 必须可以通过 append(_:) 方法添加一个新元素到容器里。
 必须可以通过 count 属性获取容器中元素的数量，并返回一个 Int 值。
 必须可以通过索引值类型为 Int 的下标检索到容器中的每一个元素。
 */

struct IntStack: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    // 为了修改值类型属性
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分
//    指定 ItemType 为 Int 类型，即 typealias ItemType = Int，从而将 Container 协议中抽象的 ItemType 类型转换为具体的 Int 类型。
    // 由于Swift的类型推断，你实际上不用 声明 ItemType 为 Int
    typealias ItemType = Int
    
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

var intStack1 = IntStack()
intStack1.push(1)
intStack1.push(3)
intStack1.push(5)
intStack1.append(9)
print(intStack1[3])
// 使用泛型遵从协议
struct Stack1<Element>: Container {
    // Stack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container 协议的实现部分
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

// 通过扩展一个存在的类型来指定关联类型

//如同上面的泛型 Stack 结构体一样，Array 的 append(_:) 方法和下标确保了 Swift 可以推断出 ItemType 的类型。定义了这个扩展后，你可以将任意 Array 当作 Container 来使用。
extension Array: Container {
    
}

// 约束关联类型
protocol Container1 {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// 为关联类型定义约束

// 泛型 C1    泛型 C2
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
        
        // 检查两个容器含有相同数量的元素
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // 检查每一对元素是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // 所有元素都匹配，返回 true
        return true
}

/*
 C1 必须符合 Container 协议（写作 C1: Container）。
 C2 必须符合 Container 协议（写作 C2: Container）。
 C1 的 ItemType 必须和 C2 的 ItemType类型相同（写作 C1.ItemType == C2.ItemType）。
 C1 的 ItemType 必须符合 Equatable 协议（写作 C1.ItemType: Equatable）。
 */

/*
 someContainer 是一个 C1 类型的容器。
 anotherContainer 是一个 C2 类型的容器。
 someContainer 和 anotherContainer 包含相同类型的元素。
 someContainer 中的元素可以通过不等于操作符（!=）来检查它们是否彼此不同。
 */


var stackOfStrings2 = Stack1<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings2, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
// 打印 “All items match.”

extension Stack1 where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if stackOfStrings2.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}
// 打印 "Top element is tres."

//extension Container where Item: Equatable {
//    func startsWith(_ item: Item) -> Bool {
//        return count >= 1 && self[0] == item
//    }
//}

//if [9, 9, 9].startsWith(42) {
//    print("Starts with 42.")
//} else {
//    print("Starts with something else.")
//}
// 打印 "Starts with something else."

//extension Container where Item == Double {
//    func average() -> Double {
//        var sum = 0.0
//        for index in 0..<count {
//            sum += self[index]
//        }
//        return sum / Double(count)
//    }
//}
//print([1260.0, 1200.0, 98.6, 37.0].average())
// 打印 "648.9"

ExtensionsWithAGenericWhereClause().test()
