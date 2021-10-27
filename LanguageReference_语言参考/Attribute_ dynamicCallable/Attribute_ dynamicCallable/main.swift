//
//  main.swift
//  Attribute_ dynamicCallable
//
//  Created by vine on 2020/4/13.
//  Copyright © 2020 vine. All rights reserved.
//

import Foundation

// 动态可写
@dynamicCallable
class TelephoneExchange {
    func dynamicallyCall(withArguments phoneNumber: [Int]) {
        if phoneNumber == [4, 1, 1] {
            print("Get Swift help on forums.swift.org")
        } else {
            print("Unrecognized number")
        }
    }
}

let dial = TelephoneExchange()

// Use a dynamic method call.
// 使用动态方法调用
dial(4, 1, 1)
// Prints "Get Swift help on forums.swift.org"

dial(8, 6, 7, 5, 3, 0, 9)
// Prints "Unrecognized number"

// Call the underlying method directly.
// 直接调用基础方法。
dial.dynamicallyCall(withArguments: [4, 1, 1])

// 动态可调用
@dynamicCallable
struct Repeater {
    func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, Int>) -> String {
        return pairs.map { label, count in
                repeatElement(label, count: count).joined(separator: " ")
            }.joined(separator: "\n")
    }
}

let repeatLabels = Repeater()
print(repeatLabels(a: 1, b: 2, c: 3, b: 2, a: 1))

let repeaterTest = Repeater()
let testResult = repeaterTest(1, 2, 3)
print("testResult:\(testResult):end")
// 下标访问

// 动态成员查找
@dynamicMemberLookup
struct DynamicStruct {
    var dictionary = ["someDynamicMember": 325,
                      "someOtherMember": 787]
    subscript(dynamicMember member: String) -> Int {
        return dictionary[member] ?? 1054
    }
}

var s = DynamicStruct()


// Use dynamic member lookup.
// 使用动态成员查找。
let dynamic = s.someDynamicMember
print(dynamic)
// Prints "325"

//Cannot assign to property: 's' is immutable
//s.id = 3
s.dictionary = ["id": 1]

print("id maybe is not exist:\(s.id)\n")

print("name maybe is not exist:\(s.name)\n")

// Call the underlying subscript directly.
//直接调用基础下标。
let equivalent = s[dynamicMember: "someDynamicMember"]
print(dynamic == equivalent)
// Prints "true"
print(s.someDynamicMember == s[dynamicMember: "someDynamicMember"])
// Prints "true"

struct Point {
    var x, y: Int
}

// 动态成员查找, 透传包装
@dynamicMemberLookup
struct PassthroughWrapper<Value> {
    var value: Value
    subscript<T>(dynamicMember member: KeyPath<Value, T>) -> T {
        get { return value[keyPath: member] }
    }
}

let point = Point(x: 381, y: 431)
var wrapper = PassthroughWrapper(value: point)
print("dynamic memeber look up x: \(wrapper.x)\n")

let y = wrapper.y
print("dynamic memeber look up y: \(y)\n")

// 分辨率
struct Resolution {
    var width = 0
    var height = 0
}
// 视频模型
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    // 帧率
    var frameRate = 0.0
    var name: String?
}

let someVideoMode = VideoMode()
let videoWrapper = PassthroughWrapper(value: someVideoMode)

print("The width of someResolution is \(someVideoMode.resolution.width)")

print("The height of someResolution is \(videoWrapper.resolution.height)")

// 创建一个临时分辨率
let tempResolution = Resolution()
// 分辨率包装器
let resolutionWrapper = PassthroughWrapper(value: tempResolution)
print("temp:\(tempResolution.width)")
print("The width of someResolution is \(resolutionWrapper.width)")

// MARK: Example
let app = App()
try configure(app)
try app.run()
