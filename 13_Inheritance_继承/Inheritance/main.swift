//
//  main.swift
//  Inheritance
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// MARK: 继承
// 一个类可以继承另一个类的方法，属性和其他特性。
// 当一个类继承其他类时，被继承类叫做超类或者父类

// 类可以调用和访问超类中的方法、属性和下标
// 可以重写这些 方法、属性、下标 来优化或修改他们的行为

// MARK: 基类
// 不继承于其他类的类，称之为基类

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // Nothing
    }
}

//
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle)")
//Vehicle: Inheritance.Vehicle
print("Vehicle: \(someVehicle.description)")
//Vehicle: traveling at 0.0 miles per hour

// MARK: 子类生成
// 子类生成是指在一个已有类的基础上创建一个新的类。
// 子类继承父类的特性，并且可以进一步完善。还可以给子类添加新的特性。

// 为了指明某各类的超类，将超类名写在子类名的后面，用冒号分隔
//class SomeClass: SomeSuperclass {
//    // 这里是子类的定义
//}

class Bicycle: Vehicle {
    var hasBasket = false
}

// 创建一个自行车，这个车自动获得Vehicle类的所有属性，还有自己定义的属性。然后指定有 篮子
let bicycle = Bicycle()
bicycle.hasBasket = true;

// 修改Bicyle实例所继承的currentSpeed属性，和查询实例所继承的description属性
bicycle.currentSpeed = 15.0
print("Bicyle:\(bicycle.description)")

// 子类还可以被其他类继承

// 创建一个双人自行车类
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

// Tandem 从 Bicyle继承了所有属性和方法，这又使他同时继承 Vehicle的所有属性方法。
// Tandem也增加了一个新的叫做currentNumberOfPassengers的存储属性，默认值是0
// 可以使用父类的属性和方法
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// 打印："Tandem: traveling at 22.0 miles per hour"

// MARK: 重写
// 子类可以为继承来的、实例方法，类方法、实例属性、下标、提供自己定制的实现。我么把这行行为叫做重写。
// 对需要重写的特性，需要添加 override关键字。
// 任何缺少override关键字的重写都会在编译时被诊断为错误

// 访问父类的方法，属性及下标

// 可以使用super前缀来访问超类版本的，方法、属性、下标

// MARK:重写方法
// 在子类中，你可以重谢继承来实现实例方法或类方法，提供一个定制或替代的方法实现。

class Train: Vehicle {
    //这里重写方法
    override func makeNoise() {
        //这里是火车
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()

// MARK: 重写属性

// 你可以重写继承来的属性或类型属性，提供自己定制的getter 和setter，或添加属性观察器是重写的属性可以观察属性值什么时候开始改变。
//你可以提供定制的 getter（或 setter）来重写任意继承来的属性，无论继承来的属性是存储型的还是计算型的属性。子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型。你在重写一个属性时，必需将它的名字和类型都写出来。这样才能使编译器去检查你重写的属性是与超类中同名同类型的属性相匹配的。

// 你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供getter和setter即可。
// 但是，你不可以将一个继承来的读写属性重写为一个只读属性。

// 注意 如果你在重写属性中提供了 setter，那么你也一定要提供 getter。如果你不想在重写版本中的 getter 里修改继承来的属性值，你可以直接通过super.someProperty来返回继承来的值，其中someProperty是你要重写的属性的名字。

class Car: Vehicle {
    var gear = 1
    override var description: String {
        // 这里可以调用父类的属性
        let des = super.description
        return des + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// 打印 "Car: traveling at 25.0 miles per hour in gear 3"

// 这里我们可以重写属性观察器
//你可以通过重写属性为一个继承来的属性添加属性观察器。这样一来，当继承来的属性值发生改变时，你就会被通知到，无论那个属性原本是如何实现的。关于属性观察器的更多内容，请看属性观察器。

//注意 你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供willSet或didSet实现是不恰当。 此外还要注意，你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。


class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
// 打印 "AutomaticCar: traveling at 35.0 miles per hour in gear 4"

// MARK: 防止重写
// 可以通过把， 方法、属性、下标标记为final来防止他们被重写。
// 如果你重写了带有final标记的方法、属性、下标、编译时会报错。
// 在类扩展中的方法、属性、下标也是可以定义为final的。
// 你也可以通过在关键字 class 前添加 final修饰符 final class 来将整个类标记为 final的。
// 这样的类是不可被继承的。


















