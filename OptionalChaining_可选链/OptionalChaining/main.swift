//
//  main.swift
//  OptionalChaining
//
//  Created by mac on 2018/4/20.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

//可选链式调用是一种可以在当前值可能为nil的可选值上请求和调用属性、方法及下标的方法。如果可选值有值，那么调用就会成功；如果可选值是nil，那么调用将返回nil。多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为nil，整个调用链都会失败，即返回nil。


//通过在想调用的属性、方法、或下标的可选值后面放一个问号（?），可以定义一个可选链。这一点很像在可选值后面放一个叹号（!）来强制展开它的值。它们的主要区别在于当可选值为空时可选链式调用只会调用失败，然而强制展开将会触发运行时错误。

// 为可选链式调用定义模型类
// 通过使用可选链式调用可以调用多层属性、方法、下标。

class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    //这里是只读属性
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// 打印 “Unable to retrieve the number of rooms.”

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
// 现在john.residence 为 nil 但是我们依然可以进行设置 someAddress
john.residence?.address = someAddress

// 等号右边的代码不会被执行

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
// 这里是直接调用一个函数。然后将返回值赋值给变量
john.residence?.address = createAddress()

//如果在可选值上通过可选链式调用来调用这个方法，该方法的返回类型会是Void?，而不是Void，因为通过可选链式调用得到的返回值都是可选的。这样我们就可以使用if语句来判断能否成功调用printNumberOfRooms()方法，即使方法本身没有定义返回值。通过判断返回值是否为nil可以判断调用是否成功：


//同样的，可以据此判断通过可选链式调用为属性赋值是否成功。在上面的通过可选链式调用访问属性的例子中，我们尝试给john.residence中的address属性赋值，即使residence为nil。通过可选链式调用给属性赋值会返回Void?，通过判断返回值是否为nil就可以知道赋值是否成功：

// 通过可选链式调用访问下标
// 通过可选链式调用访问可选值的下标时，应该将问好放在下标括号的前面而不是后面。
// 可选链式调用的问号一般直接跟在可选表达式的后面

//下面这个例子用下标访问john.residence属性存储的Residence实例的rooms数组中的第一个房间的名称，因为john.residence为nil，所以下标调用失败了：
//在这个例子中，问号直接放在john.residence的后面，并且在方括号的前面，因为john.residence是可选值。


if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// 打印 “Unable to retrieve the first room name.”

// 使用可选链式调用进行赋值
// 当前residence 为 nil 赋值失败
john.residence?[0] = Room(name: "Bathroom")

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// 打印 “The first room name is Living Room.”

// 访问可选类型的下标
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]

testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// "Dave" 数组现在是 [91, 82, 84]，"Bev" 数组现在是 [80, 94, 81]

// 链接多层可选链式调用

//如果你访问的值不是可选的，可选链式调用将会返回可选值。
//如果你访问的值就是可选的，可选链式调用不会让可选返回值变得“更可选”。

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// 打印 “Unable to retrieve the address.”

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// 打印 “John's street name is Laurel Street.”

// 在方法的可选返回值上进行可选链式调用

if let buildingIdentifier1 = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier1).")
}
// 打印 “John's building identifier is The Larches.”

// 如果要在该方法的返回值上进行可选链式调用，在方法的圆括号后面加上问号即可
// 在上面的例子中，在方法的圆括号后面加上问号是因为你要在buildingIdentifier()方法的可选返回值上进行可选链式调用，而不是方法本身

if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
// 打印 “John's building identifier begins with "The".”







