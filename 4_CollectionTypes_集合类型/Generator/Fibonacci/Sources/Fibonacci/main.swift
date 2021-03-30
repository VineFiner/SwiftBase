print("Hello, world!")

// 简单输出斐波那契数列前 N 个数

func fab(max: Int) {
    var n = 0, a = 0, b = 1
    while n < max {
        print(b)
        (a, b) = (b, a + b)
        n = n + 1
    }
}

print("输出斐波那契数列")
fab(max: 5)

// 提高可复用性
func fab2(max: Int) -> [Int] {
    var n = 0, a = 0, b = 1
    var L = [Int]()
    while n < max {
        L.append(b)
        (a, b) = (b, a + b)
        n = n + 1
    }
    return L
}
print("提高复用性，输出斐波那契数列")
for n in fab2(max: 5) {
    print(n)
}

struct Fab: Sequence, IteratorProtocol {
    var n = 0, a = 0, b = 1
    var maxNumber = 0
    init(_ maxNumber: Int) {
        self.maxNumber = maxNumber
    }

    // 结构体和枚举是值类型，默认情况下无法在其实例方法中修改值类型的属性
    // mutating 修改实例方法中值类型的属性
    mutating func next() -> Int? {
        if self.n < self.maxNumber {
            let r = self.b
            (self.a, self.b) = (self.b, self.a + self.b)
            self.n = self.n+1
            return r
        } else {
            return nil
        }
    }
}

print("Class 改写")

let iterable = Fab(5)
for i in iterable {
    print(i)
}

print("\n\n\n\n\n\n")
struct Countdown: Sequence, IteratorProtocol {
    var count: Int
    // 结构体和枚举是值类型，默认情况下无法在其实例方法中修改值类型的属性
    
    // mutating 修改实例方法中值类型的属性
    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            // 这里延时执行，最后执行
            defer {
                count -= 1
            }
            defer { print("First defer") }
            defer { print("Second defer") }
            return count
        }
    }
}

let threeToGo = Countdown(count: 3)
for i in threeToGo {
    print(i)
}
print("\n\n\n\n\n\n")

struct ReverseIterator: IteratorProtocol {
    var element: Int
    init<T>(array:[T]) {
        self.element = array.count - 1
    }
    mutating func next() -> Int? {
        let result:Int? = self.element < 0 ? nil : element
        element -= 1
        return result
    }
}

let arr = ["A","B","C","D","E"]

var itertator = ReverseIterator(array:arr)
while let i = itertator.next(){
    print("element \(i) of the array is \(arr[i])")
}

print("\n\n\n\n\n")

let fibonacci = Fibonacci()
fibonacci.test()
