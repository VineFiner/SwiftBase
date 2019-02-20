//
//  main.swift
//  AutomaticReferenceCounting
//
//  Created by mac on 2018/4/20.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

class Person1 {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person1?
var reference2: Person1?
var reference3: Person1?

reference1 = Person1(name: "John Appleseed")
// 打印 "John Appleseed is being initialized"

reference2 = reference1
reference3 = reference1


reference1 = nil
reference2 = nil


// 类实例之间的强引用
class Person {
    let name: String
    var apartment: Apartment?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    // 这里是避免循环引用
    weak var tenant: Person?
    init(unit: String) {
        self.unit = unit
    }
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil

// 无主引用

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var john1: Customer?

john1 = Customer(name: "John Appleseed")
john1!.card = CreditCard(number: 1234_5678_9012_3456, customer: john1!)



class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
// 打印 "Canada's capital city is called Ottawa"

// 闭包引起的循环强引用

class HTMLElement1 {
    
    let name: String
    let text: String?
    
//    注意 asHTML声明为lazy属性，因为只有当元素确实需要被处理为 HTML 输出的字符串时，才需要使用asHTML。也就是说，在默认的闭包中可以使用self，因为只有当初始化完成以及self确实存在后，才能访问lazy属性。
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    // 这是一个懒加载属性
//    lazy var label1: String = {
//        let label = ""
//        return label
//    }()
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

let heading = HTMLElement1(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// 打印 "<h1>some default text</h1>"

var paragraph: HTMLElement1? = HTMLElement1(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// 打印 "<p>hello, world</p>"

paragraph = nil // 这里并没有释放对象

// 这里我们可以使用定义捕获列表作为闭包的一部分

//lazy var someClosure: (Int, String) -> String = {
//    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
//    // closure body goes here
//}

//lazy var someClosure: Void -> String = {
//    [unowned self, weak delegate = self.delegate!] in
//    // 这里是闭包的函数体
//}

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"















