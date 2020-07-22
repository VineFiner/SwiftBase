//
//  main.swift
//  Initialization
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// MARK: 存储属性的初始赋值

// 构造过程是使用类、结构体、枚举类型的实例之前的准备过程。
// 在新实例可用前必须执行这个过程。
// 具体操作包括设置实例中每个存储型实例的初始值和执行其他必须的设置或初始化工作。

// 通过定义构造器来实现构造过程，Swift的构造器无需返回值。它们的主要任务是保证新实例在第一次使用前完成正确的初始化。

// 类和结构体再创建示例时，必须为所有存储属性设置合适的初始值。存储属性的值不能处于一个未知的状态。
// 当你为存储属性设置默认值或者在构造器中为其赋值时，他们的值是被直接设置的。不会触发任何属性观察者

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// 打印 "The default temperature is 32.0° Fahrenheit"
// 结构体定义了一个不带参数的构造器 init， 并在里面讲存储属性 temperature 的值初始化为 32.0

struct Fahrenheit1 {
    var temperature = 32.0
}
// 构造参数
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.0
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius 是 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius 是 0.0

//如果你在定义构造器时没有提供参数的外部名字，Swift 会为构造器的每个参数自动生成一个跟内部名字相同的外部名。

// MARK: 自定义构造过程

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//let veryGreen = Color(0.0, 1.0, 0.0)
// 报编译时错误，需要外部名称

struct Celsius1 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double){
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = Celsius1(37.0)
// bodyTemperature.temperatureInCelsius 为 37.0

// 可选参数类型

class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// 打印 "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."

//构造过程中常量属性的赋值

//你可以在构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改。
// 对于类的实例来说，他的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。

class SurveyQuestion1 {
    let text: String
    var response: String?
    init(text: String) {
        // 这里是常量、但是还是可以修改的。
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion1 = SurveyQuestion1(text: "How about beets?")
beetsQuestion1.ask()
// 打印 "How about beets?"
beetsQuestion1.response = "I also like beets. (But not with cheese.)"

// MARK: 默认构造器

// 如果结构体或类的所有属性都有默认值，同时没有自定义的构造器。
// 那么Swift会给这些结构体或类听一个默认构造器

class ShoppingListItem1 {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem1()
// 这里 Item 的 name属性默认是 nil

// MARK: 值类型的构造器

// 结构体的逐一成员构造器

//除了上面提到的默认构造器，如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值。
//逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法。我们在调用逐一成员构造器时，通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值。

struct Frame {
    // 这里是没有默认值的
    var x: Double
    var y = 0.0
    var widht = 0.0, height = 0.0
}

let frame = Frame(x: 0, y: 0, widht: 1.0, height: 1.0)

struct Size1 {
    var width = 0.0
    var height = 0.0
}
let twoByTwo = Size1(width: 2.0, height: 2.0)

// MARK: 值类型的构造器代理

//对于值类型，你可以使用 self.init 在自定义的构造器中引用相同类型中的其它构造器。并且你只能在构造器内部调用 self.init。
//请注意，如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器）。这种限制可以防止你为值类型增加了一个额外的且十分复杂的构造器之后，仍然有人错误的使用自动生成的构造器

//注意 假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中。想查看更多内容，请查看扩展章节。

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    
    init() {
        
    }
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }

}

//第一个 Rect 构造器 init()，在功能上跟没有自定义构造器时自动获得的默认构造器是一样的。这个构造器是一个空函数，使用一对大括号 {} 来表示。调用这个构造器将返回一个 Rect 实例，它的 origin 和 size 属性都使用定义时的默认值 Point(x: 0.0, y: 0.0) 和 Size(width: 0.0, height: 0.0)：

let basicRect = Rect()
// basicRect 的 origin 是 (0.0, 0.0)，size 是 (0.0, 0.0)

//第二个 Rect 构造器 init(origin:size:)，在功能上跟结构体在没有自定义构造器时获得的逐一成员构造器是一样的。这个构造器只是简单地将 origin 和 size 的参数值赋给对应的存储型属性：

let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 5.0, height: 5.0))
// originRect 的 origin 是 (2.0, 2.0)，size 是 (5.0, 5.0)

//第三个 Rect 构造器 init(center:size:) 稍微复杂一点。它先通过 center 和 size 的值计算出 origin 的坐标，然后再调用（或者说代理给）init(origin:size:) 构造器来将新的 origin 和 size 值赋值到对应的属性中：

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
// centerRect 的 origin 是 (2.5, 2.5)，size 是 (3.0, 3.0)

//注意 如果你想用另外一种不需要自己定义init()和init(origin:size:)的方式来实现这个例子，请参考扩展。

// MARK: 类的继承和构造过程

//类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。
//Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。

//指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类合适的构造器来实现父类的初始化。

//每一个类都必须至少拥有一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。具体内容请参考后续章节构造器的自动继承。

//你应当只在必要的时候为类提供便利构造器，比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器，能够节省更多开发时间并让类的构造过程更清晰明了。

// 类的构造器代理规则

// 规则 1 ：指定构造器必须调用其直接父类的指定构造器
// 规则 2 ：便利构造器必须调用同类中定义的其他构造器
// 规则 3 ：便利构造器最后必须调用指定构造器。

// MARK: 指定构造器必须总是向上代理
// MARK: 便利构造器必须总是横向代理

// MAKR: 两段式构造过程

//Swift 中类的构造过程包含两个阶段。第一个阶段，类中的每个存储型属性赋一个初始值。当每个存储型属性的初始值被赋值后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步定制它们的存储型属性。

// 安全检查 1
// 指定构造器必须保证它所在类的所有属性都必须先初始化完成，之后才能将其他构造任务向上代理给父类中的构造器。

// 安全检查 2
// 指定构造器必须先向上代理调用父类的构造器然后再为继承的属性设置新值，如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。

// 安全检查 3
// 便利构造器必须为任意属性赋新值之前代理调用同一类中的其他构造器，如果没有这么做，便利构造器赋予的新值将被同意类中其他指定构造器所覆盖。

// 安全检查 4
// 构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能使用self 作为一个值。
// 类实例在第一阶段结束以前并不是完全有效的。只要第一阶段完成后，该实例才会成为有效实例。才能访问属性和调用方法。


// 阶段 1
// 确认内存，赋值存储属性。向上执行
/*
 某个指定构造器或便利构造器被调用。
 完成新实例内存的分配，但此时内存还没有被初始化。
 指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
 指定构造器将调用父类的构造器，完成父类属性的初始化。
 这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部。
 当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。
 */

// 阶段 2
/*
 从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问 self、修改它的属性并调用实例方法等等。
 最终，任意构造器链中的便利构造器可以有机会定制实例和使用 self。
 */

// 构造器的继承和重写
// 默认情况下不会继承父类的构造器

//如果你编写了一个和父类便利构造器相匹配的子类构造器，由于子类不能直接调用父类的便利构造器（每个规则都在上文类的构造器代理规则有所描述），因此，严格意义上来讲，你的子类并未对一个父类构造器提供重写。最后的结果就是，你在子类中“重写”一个父类便利构造器时，不需要加 override 修饰符。

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

//Vehicle 类只为存储型属性提供默认值，也没有提供自定义构造器。因此，它会自动获得一个默认构造器，具体内容请参考默认构造器。自动获得的默认构造器总是类中的指定构造器，它可以用于创建numberOfWheels 为 0 的 Vehicle 实例：

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")
// Vehicle: 0 wheel(s)

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
// 子类可以在初始化时修改继承来的变量属性，但是不能修改继承来常量属性。
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")
// 打印 "Bicycle: 2 wheel(s)"

// 构造器的自动继承
// 规则 1
// 如果子类没有定义任何指定构造器，他将自动继承父类所有的自定构造器。

// 规则 2
// 如果子类提供了所有父类指定构造器的实现-----将自动继承父类所有的便利构造器
// 子类可以将父类的指定构造器实现为便利构造器

class Food {
    var name: String
    // 指定构造器
    init(name: String) {
        self.name = name
    }
    // 便利构造器， 需要添加关键字
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

// 这里调用的指定构造器
let namedMeat = Food(name: "Bacon")
// namedMeat 的名字是 "Bacon"

// 这里调用的是便利构造器
let mysteryMeat = Food()
// mysteryMeat 的名字是 [Unnamed]

class RecipeIngredient: Food {
    // 子类中的存储属性
    var quantity: Int
    // 子类中的指定构造器
    init(name: String, quantity: Int) {
        //指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化
        self.quantity = quantity
        // 指定构造器将调用父类的构造器，完成父类属性的初始化
        // 指定构造器必须调用其直接父类的指定构造器
//        super.init() error
        super.init(name: name)
    }
    
    // 便利构造器必须调用同类中其他构造器
    // 便利构造器 最后 必须调用指定构造器
    // 重写父类指定构造器，可以实现为便利构造器
    // 尽管 将父类中的指定构造器重写为了便利构造器，但是他依然提供了父类的所有指定构造器实现。因此，会自动继承父类的所有便利构造器
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
    
}
//在这个例子中，RecipeIngredient 的父类是 Food，它有一个便利构造器 init()。这个便利构造器会被RecipeIngredient 继承。这个继承版本的 init() 在功能上跟 Food 提供的版本是一样的，只是它会代理到RecipeIngredient 版本的 init(name: String) 而不是 Food 提供的版本。

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased: Bool = false
    // 只读属性
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "✔️" : "❎"
        return output
    }
}
//由于它为自己引入的所有属性都提供了默认值，并且自己没有定义任何构造器，ShoppingListItem 将自动继承所有父类中的指定构造器和便利构造器。
var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
// 1 x orange juice ✔
// 1 x bacon ✘
// 6 x eggs ✘

// MARK: 可失败构造器

//如果一个类、结构体或枚举类型的对象，在构造过程中有可能失败，则为其定义一个可失败构造器是很有用的。这里所指的“失败” 指的是，如给构造器传入无效的参数值，或缺少某种所需的外部资源，又或是不满足某种必要的条件等。

// 可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
//严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确构造。因此你只是用return nil表明可失败构造器构造失败，而不要用关键字return来表明构造成功。

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
// someCreature 的类型是 Animal? 而不是 Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// 打印 "An animal was initialized with a species of Giraffe"

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// 打印 "This is a defined temperature unit, so initialization succeeded."

// 带有原始值的枚举类型会自带一个可失败构造器
// 这里是初始化一个类型为 字符的 枚举
enum TemperatureUnit1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit1 = TemperatureUnit1(rawValue: "F")
if fahrenheitUnit1 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// 打印 "This is a defined temperature unit, so initialization succeeded."

//类，结构体，枚举的可失败构造器可以横向代理到同类型中的其他可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。

//无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止，接下来的任何构造代码不会再被执行。

//可失败构造器也可以代理到其它的非可失败构造器。通过这种方式，你可以增加一个可能的失败状态到现有的构造过程中。


class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

// 重写一个可失败构造器

//如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。
//当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。
//你可以用非可失败构造器重写可失败构造器，但反过来却不行。

class Document {
    var name: String?
    var pageCount: Int?
    // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
    init() {}
    // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
    init(name: String, pageCount: Int) {
        self.name = name
        self.pageCount = pageCount
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    // 重写父类可失败构造器
//    override init?(name: String) {
//        super.init()
//        if name.isEmpty {
//            self.name = "[Untitled]"
//        } else {
//            self.name = name
//        }
//    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
    // 非可失败构造器重写为可失败构造器失败
//    Failable initializer 'init(name:pageCount:)' cannot override a non-failable initializer
//    override init?(name: String, pageCount: Int) {
//        super.init()
//    }
}

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

// MARK: 必须构造器

//如果子类继承的构造器能满足必要构造器的要求，则无须在子类中显式提供必要构造器的实现。
class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}

class SomeSubclass: SomeClass {
    required init() {
        // 构造器的实现代码
    }
}
// MARK: 通过闭包或函数设置属性的默认值

//如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的 self 属性，或者调用任何实例方法。

struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
//      只有 getter 没有 setter 的计算属性就是只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值
//     必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。
    
    var boardColors1: [Bool] {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for _ in 1...8 {
            for _ in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
// Prints "true"
print(board.squareIsBlackAt(row: 7, column: 7))
// Prints "false”












