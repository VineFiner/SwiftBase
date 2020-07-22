// https://segmentfault.com/a/1190000004105365
// 斐波那契数列型-从数学角度学习 Swift 序列

import UIKit

var str = "Hello, World"

print(str)

func nthFibonacci(n: Int) -> Int {
    var i = 0
    var j = 1
    for _ in 0..<n {
        (i, j) = (j, i + j)
    }
    return i
}

nthFibonacci(n: 42)

//struct AnySequence<Element>: Sequence {
//    init<I: IteratorProtocol>(_ makeUnderlyingGenerator: () -> I) where I.Element == Element {
//
//    }
//}
//
//func anyGenerator<Element>(body: () -> Element?) -> AnyGenerator<Element>
//
//let fibonacciNumbers = AnySequence { () -> AnyGenerator<Int> in
//    // 为了创建一个生成器，我们首先需要建立一些状态...
//    var i = 0
//    var j = 1
//    return anyGenerator {
//        // ... 然后生成器进行改变
//        // 调用 next() 一次获取每一项
//        // (代码看起来是不是很熟悉？)
//        (i, j) = (j, i + j)
//        return i
//    }
//}

/// 这里是迭代器
struct CustomIterator: IteratorProtocol {
    var num = 0
    mutating func next() -> Int? {
        num += 1
        if num == 10 {
            return nil
        }
        return num
    }
}

var iter = CustomIterator()
while let num = iter.next() {
    print(num)  // 1,2,3,4,5,6,7,8,9
}

// 这里是序列
struct CustomSequence: Sequence {
    func makeIterator() -> CustomIterator {
        return CustomIterator()
    }
}

let sequence = CustomSequence()
for item in sequence {
    print(item)   // 1,2,3,4,5,6,7,8,9
}

print("\n\n\n\n\n\n")

struct Countdown: Sequence, IteratorProtocol {
    var count: Int

    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
}

let threeToGo = Countdown(count: 3)
for i in threeToGo {
    print(i)
}

print("\n\n\n\n\n\n")

struct RecurrenceRelation<Element>: Sequence, IteratorProtocol {
    private let recurrence: (_ T: UnsafePointer<Element>, _ n: Int) -> Element
    private var storage: [Element]
    
    /// - 参数 initialTerms: 序列的第一个元素集合.
    /// 数组的个数也就代表这个递推的排序。
    /// - 参数 recurrence：根据前面的元素推算出第 n 个元素
    init(_ initialTerms: [Element], _ recurrence: @escaping (_ T: UnsafePointer<Element>, _ n: Int) -> Element)
    {
        self.recurrence = recurrence
        storage = initialTerms
    }
    // SequenceType requirement
    func generate() -> RecurrenceRelation<Element> { return self }
    
    // GeneratorType requirement
    private var iteration = 0
    mutating func next() -> Element?
    {
        // 首先推算出所有的初始元素值
        if iteration < storage.count {
            iteration += 1
            return storage[iteration]
        }
        
        let newValue = storage.withUnsafeBufferPointer { buf in
            // 调用闭包，传入内存地址中的指针的偏移量，知道 T[n-1] 是数组中最后一个元素
            return recurrence(buf.baseAddress + storage.count - iteration, iteration)
        }

//        // 存储下一个的值，丢弃到最旧的值
        storage.remove(at: 0)
        storage.append(newValue)
        iteration += 1
        return newValue
    }
}
