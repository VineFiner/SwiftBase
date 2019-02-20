//
//  main.swift
//  AccessControl
//
//  Created by mac on 2018/4/23.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 访问限制允许你隐藏代码的实现部分、并指定要给偏好的接口让其他代码可以访问和使用。
// 你可以给特定的单个类型（类、结构体、枚举）设置访问限制。

// 模块和源文件
// Swift的访问控制模型基于模块和源文件的概念
// 模块是单一的代码分配单元 一个框架或应用程序会作为的独立的单元构建和发布并且可以使用Swift的 import 关键字导入到另一个模块


// 访问限制
// Swift 为代码的实体提供了五个不同的访问级别。这些访问级别和定义实体的源文件相关，并且也和源文件所属的模块相关。

// Open 访问、 定义模块中的任意源文件访问，可以被另一模块的源文件访问。

// public 访问、定义模块中的任意源文件访问、可以被另一模块的源文件访问。

// internal 模块内任意源文件

// File-private 当前源文件

// private // 实体的封闭声明中

// 对于 Open 和 public

// public 不允许模块外 进行继承 和 重写
// open 可以在其他模块中被继承 和   重写

// 访问级别指导标准
// 实体不可以被更低访问级别的实体定义

/*
 一个 public 的变量其类型的访问级别不能是 internal, file-private 或是 private，因为在使用 public 变量的地方可能没有这些类型的访问权限。
 一个函数不能比它的参数类型和返回类型访问级别高，因为函数可以使用的环境而其参数和返回类型却不能使用。
 */

// 默认访问级别

// 默认 internal 级别

// 单目标应用的访问级别

// 你可以将代码的一部分实现标注为 file private 或 private 以 对模块中的其他代码隐藏他们的实现细节。

// 框架的访问级别

// 当开发一个框架时， 将该框架的对外接口标注为 open 或 public
// 对于 open 和 public 的区别是 ，public 不能被其他模块继承和重写。

// 单元测试目标的访问级别
// 使用 @testable 属性标注了导入的生产模块，单元测试目标就能访问热河internal的实体

// 访问控制语法

// 通过在提示的引入之前添加 open、public、internal、fileprivate、private 修饰符来定义访问级别

public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

public class SomePublicClass1 {                          // explicitly public class
    public var somePublicProperty = 0               // explicitly public class member
    var someInternalProperty = 0                      // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}   // explicitly file-private class member
    private func somePrivateMethod() {}           // explicitly private class member
}

class SomeInternalClass1 {                                 // implicitly internal class
    var someInternalProperty = 0                      // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}   // explicitly file-private class member
    private func somePrivateMethod() {}            // explicitly private class member
}

fileprivate class SomeFilePrivateClass1 {            // explicitly file-private class
    func someFilePrivateMethod() {}                 // implicitly file-private class member
    private func somePrivateMethod() {}           // explicitly private class member
}

private class SomePrivateClass1 {                     // explicitly private class
    func somePrivateMethod() {}                     // implicitly private class member
}

// 元组类型
// 元组类型的访问级别是所有类型里最严格的，例如，如果你将两个不同类型的元素组成了一个元组，一个元素的访问级别是 internal，另一个是private，那么这个元组的类型是 private 级别的。
// 元组的类型不像类、结构体、枚举和函数那样有一个单独的定义。元组类型的访问级别会在使用的时候自动推断出来。不需要显示指明。

// 函数类型
// 对于函数类型的访问级别是由函数成员类型和返回类型中最严格访问级别决定。

//Function must be declared private or fileprivate because its result uses a private type

//func someFunction() -> (SomeInternalClass, SomePrivateClass) {
//    // function implementation goes here
//}

// 由于返回类型是 private级别的 ，你必须使用 private 修饰符使其合法，不然编译不过
fileprivate func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // function implementation goes here
    return (SomeInternalClass(), SomePrivateClass())
}

// 枚举类型
// 枚举中独立成员自动使用该枚举类型的访问级别。你不能改独立的成员指明一个不同的访问级别。

// 原始值和关联值
// 枚举定义中的原始值和关联值使用的类型必须有一个不低于枚举的访问级别。
// 不能使用一个 private 类型作为一个 internal 级别的枚举类型中的原始值类型


// 嵌套类型
// private 级别的类型中定义的嵌套类型自动为 private 级别。fileprivate 级别的类型中定义的嵌套类型自动为 fileprivate 级别。public 或 internal 级别的类型中定义的嵌套类型自动为 internal 级别。如果你想让嵌套类型是 public 级别的，你必须将其显式指明为 public。

// 子类
//你可以继承任何类只要是在当前可以访问的上下文环境中。但子类不能高于父类的访问级别，例如，你不能写一个 internal 父类的 public 子类。


// 常量、变量、属性和下标

//常量、变量、属性不能拥有比它们类型更高的访问级别。例如，你不能写一个public 的属性而它的类型是 private 的。类似的，下标也不能拥有比它的索引类型和返回类型更高的访问级别。

// Getters 和 Setters

// 常量、变量、属性、和下标的getter和 setter 自动接收他们所属常量、变量、属性和下标的访问级别。

//你可以给 setter 函数一个比相对应 getter 函数更低的访问级别以限制变量、属性、下标的读写权限。你可以通过在 var 和 subscript 的置入器之前书写 fileprivate(set) , private(set) , 或 internal(set) 来声明更低的访问级别。

// 初始化构造器
//我们可以给自定义初始化方法设置一个低于或等于它的所属的类的访问级别。唯一的例外是必要初始化器（定义在必要初始化器）。必要初始化器必须和它所属类的访问级别一致。

//就像函数和方法的参数一样，初始化器的参数类型不能比初始化方法的访问级别还低。


// 结构体的默认成员逐一构造器

//如果结构体的存储属性时 private 的，那么它的默认成员初始化方法就是 private 级别。如果结构体的存储属性时 file private 的，那么它的默认成员初始化方法就是 file private 级别。否则就是默认的 internal 级别。正如以上默认初始化的描述，如果你想在另一个模块中使用结构体的成员初始化方法，你必须提供在定义中提供一个 public 的成员初始化方法。

// 协议

// 如果你想给一个协议类型分配一个显式的访问级别，那就在定义时指明。这让你创建的协议可以在一个明确的访问上下文中被接受。

//协议定义中的每一个要求的访问级别都自动设为与该协议相同。你不能将一个协议要求的访问级别设为与协议不同。这保证协议的所有要求都能被接受该协议的类型所见。

//注意如果你定义了一个 public 的协议，该协议的规定要求在被实现时拥有一个 public 的访问级别。这个行为不同于其他类型，一个 public 的类型的成员时 internal 访问级别。

// 协议继承

//如果你定义了一个继承已有协议的协议，这个新协议最高与它继承的协议访问级别一致。例如你不能写一个 public 的协议继承一个 internal 的协议。

// 协议遵循

//类型可以遵循更低访问级别的协议。例如，你可以定义一个可在其他模块使用的 public 类型，但它就只能在定义模块中使用如果遵循一个 internal 的协议。
//遵循了协议的类的访问级别取这个协议和该类的访问级别的最小者。如果这个类型是 public 级别的，它所遵循的协议是 internal 级别，这个类型就是 internal 级别的。

//当你写或是扩张一个类型以遵循协议时，你必须确保该类按协议要求的实现方法与该协议的访问级别一致。例如，一个 public 的类遵循一个 internal 协议，该类的方法实现至少是 “internal” 的。

// 扩展
// 你不能给用于协议遵循的扩展显式标注访问权限修饰符。相反，在扩展中使用协议自身的访问权限作为协议实现的默认访问权限。

// 扩展中的私有成员

/*
 在原本的声明中声明一个私有成员，然后在同一文件的扩展中访问它；
 在扩展中声明一个私有成员，然后在同一文件的其他扩展中访问它；
 在扩展中声明一个私有成员，然后在同一文件的原本声明中访问它。
 */

// 泛型

//泛指类型和泛指函数的访问级别取泛指类型或函数以及泛型类型参数的访问级别的最小值。

// 类型别名

// 不高于原类型
//任何你定义的类型同义名都被视为不同的类型以进行访问控制。一个类型同义名的访问级别不高于原类型。例如，一个 private 的类型同义名可联系到 private ，file-private ，internal ，public 或open 的类型，但 public 的类型同义名不可联系到 internal ，file-private 或 private 类型。

















