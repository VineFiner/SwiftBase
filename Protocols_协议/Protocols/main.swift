//
//  main.swift
//  Protocols
//
//  Created by mac on 2018/4/23.
//  Copyright © 2018年 Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 协议
// 协议定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的恭喜。
// 类，结构体或枚举都可以遵循协议，并未协议定义的这些要求提供具体实现。某个类型能够满足某个协议的要求，就可以说该类型遵循这个协议。
// 除了尊徐协议的类型补习实现的要求外，还可以对协议进行扩展，通过扩展来实现一部分要求或者实现一些附加的功能。
// 这样遵循协议的类型就能够使用这些功能。

// 协议语法
// 协议的定义方式与类，结构体和枚举的定义非常相似

// 要让自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号 `:` 分隔。
// 遵循多个协议时，各协议之间用 ， 分隔
// 拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔。

// MARK: 属性要求
// 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不能指定属性是存储型属性还是计算型属性。
// 它只指定属性的名称和类型。此外，协议还指定属性是可读还是 可读可写的。

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

// 在协议中定义类型属性时，总是使用static关键字作为前缀。当类类型遵循协议时，处理 static关键字，还可以使用
// class 关键字来声明类型属性

protocol Anotherprotocol {
    static var someTypeProprety: Int {
        get set
    }
}

// FullyNamed协议处理要求遵循协议的类型提供fullName 属性外，并没有其他特别的要求。
//这个协议表示。任何遵循FullyName的类型。都必须有一个刻度的String类型的实例属性fullName
protocol FullyNamed {
    var fullName: String {
        get
    }
}

// 下面是一个遵循FullyName协议的简单结构体

struct Person: FullyNamed {
    var fullName: String
}

var john = Person(fullName: "John Appleseed")
john.fullName = "haha"
print(john)

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    //
    init(name: String, prefix: String? = nil) {
        self.name = name;
        self.prefix = prefix
    }
    
    var fullName: String {
        // 这里必须实现get方法
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1700 = Starship(name: "Shiftprise")
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
var ncc1702 = Starship(name: "Altprise", prefix: nil)
//Cannot assign to property: 'fullName' is a get-only property
//ncc1701.fullName = ""
print(ncc1700.fullName)
print(ncc1701.fullName)
print(ncc1702.fullName)

// 方法要求
// 协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，就像普通方法一样放在协议的定义中。
// 但不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法的参数提供默认值

// 正如属性要求中所述，在协议中定义类方法的时候，总是使用static 关键字作为前缀。当类类型遵循协议时，除了static 关键字，还可以是使用class 关键字作为前缀。

// 定义一个只含一个实例方法的协议
protocol RandomNumberGenerator {
    func random() -> Double
}

// 这里 RandomNumberGenerator协议要求遵循协议的类型必须拥有一个名为random， 返回值类型为Double的实例方法
// RandomNumberGenerator 协议并不关心每一个随机数是怎样生成的，他只要求必须提供一个随机数生成器。
// 如下所示，下边是一个遵循并符合RandomNumberGenerator协议的类。该类实现了一个叫做现行同余生成器的伪随机数算法

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.37464991998171"
print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283"

// Mutating 方法要求
// 有时需要在方法中改变方法所属的实例。例如，在值类型（即结构体和枚举）的实例方法中，将 mutating关键字作为方法的前缀，写在 func关键字之前，表示可以在该方法中修改他所属的实例以及实例的任意属性的值。

// 如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前加mutating关键字。
// 这使得结构体和枚举能够遵循此协议并满足此方法要求
// 实现协议中的 mutating 方式时， 若是类类型， 则不用写 mutating关键字。而对于结构体和枚举，则必须写mutating关键字。

// 这表明当他被调用时，该方法将会改变遵循协议的类型的实例
protocol Togglable {
    mutating func toggle()
}

// 当使用枚举或结构体实现Togglable协议时，需要提供一个带mutating前缀的toggle() 方法

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        default:
            self = .off
        }
    }
}

var lightSwith = OnOffSwitch.off
lightSwith.toggle()
print(lightSwith) // on

// 构造器要求
// 协议可以要求遵循协议的类型实现指定的构造器。你可以像编写普通构造器那样，在协议的定义里写下构造器的声明，但是不需要花括号和构造器的实体
protocol SomeInitProtocol {
    // 这里这是一个方法
    init(someParameter: Int)
}

// 构造器要求在类中的实现
// 如果被标为 final 这里不需要 使用 required修饰符
class SomeClass: SomeInitProtocol {
    // 无论是作为指定构造器，还是作为便利构造器，都必须 required 修饰符
    required init(someParameter: Int) {
        // 这里是构造器实现部分
        // 这里可以是指定构造器、或者是便利构造器
    }
}

//如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标注 required 和 override 修饰符：


//protocol SomeProtocol {
//    init()
//}
//
//class SomeSuperClass {
//    init() {
//        // 这里是构造器的实现部分
//    }
//}
//
//class SomeSubClass: SomeSuperClass, SomeProtocol {
//    // 因为遵循协议，需要加上 required
//    // 因为继承自父类，需要加上 override
//    required override init() {
//        // 这里是构造器的实现部分
//    }
//}

// 可失败构造器要求
// 协议还可以为遵循协议的类型定义可失败构造器要求。
// 遵循协议的类型可以通过可失败构造器（init？）或非可失败构造器（init）来满足协议中定义的可失败构造器要求。
// 协议中定义的非可失败构造器要求可以通过非可失败构造器（init）或隐式解包可失败构造器（init！）来满足

// 协议作为类型
// 尽管协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用。
// 协议可以像掐普通类型一样使用，使用场景如下：
/*
 1、作为函数、方法或构造器中的参数类型或返回值类型
 2、作为常量、变量或属性的类型
 3、作为数组、字典或其他容器中的元素类型
 */
// 协议时一种类型，因此协议类型的名称应与其他类型的写法相同，使用大写字母开头的驼峰试写法。

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

// MARK: 委托代理模式

// 委托是一种设计模式，他允许类或结构体将一些需要他们负责的功能委托给其他类型的实例。
// 定义协议来封装那些需要被委托的功能，这样就能确保遵循协议的类型能提供这些功能。
// 委托模式可以用来响应特定的动作，或者接收外部数据眼听的数据，而无需关心外部数据源的类型

protocol DiceGame {
    // 协议总是用 var 关键字来声明变量属性
    // 这里定义一个只读属性 dice
    // 属性类型是Dice
    var dice: Dice { get }
    // 这里定义一个play方法
    func play()
}

//'weak' must not be applied to non-class-bound 'DiceGameDelegate'; consider adding a protocol conformance that has a class bound
//'weak'不能应用于非class'DiceGameDelegate'; 考虑添加一个具有类绑定的协议一致性

protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ geme: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let game = SnakesAndLadders()
let tracker = DiceGameTracker()

game.delegate = tracker
game.play()

// 通过扩展添加协议一致性
// 即使无法修改源代码，依然可以通过扩展令已有类型遵循并符合协议。扩展可以为已有类型添加属性、方法、下标以及构造器。
// 通过扩展令已有类型遵循并符合协议时，该类型的所有实例也会随之获得西一中定义的各项功能

// 文字描述
protocol TextRepresentable {
    var textualDescription: String { get }
}

// 可以通过扩展，令先前提到的Dice类遵循并符合TextRepresentable协议
// 通过扩展遵循并符合协议，和在原始定义中遵循并符合协议的效果完全相同。
// 协议名称写在类型名之后，以冒号隔开，然后在扩展的大括号内实现协议要求的内容。
// 可以添加新的计算型属性，但是不能添加存储型属性，也不可以为已有属性添加属性观察器

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-side dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)
// 打印 “A game of Snakes and Ladders with 25 squares”

// 通过扩展遵循协议
// 当一个类型已经符合了某个协议中的所有要求，但还没有声明遵循该协议时，可以通过空扩展体的扩展来遵循该协议
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

let simonTheHamster = Hamster(name: "Simon")
// 即使满足了协议的所有要求，类型也不会自动遵循协议。必须显示地遵循协议
extension Hamster: TextRepresentable {}
// 协议可以直接当做普通类型来使用
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

// 协议类型的集合
// 协议类型可以在数组或者字典这样的集合中使用
let things: [TextRepresentable] = [game, d12, simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}

// 协议的继承
// 协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。
// 协议的继承语法与类的继承相似，多个被继承的洗衣间使用逗号分隔
protocol InheritingProtocol: SomeProtocol, Anotherprotocol {
    // 这里是协议的定义部分
}

// 协议的继承
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

// 现在我们扩展 KsnakesAndLadders
extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "⬆️ "
            case let snake where snake < 0:
                output += "⤵️ "
            default:
                output += "0️⃣ "
            }
        }
        return output
    }
    
}

print(game.prettyTextualDescription)
// A game of Snakes and Ladders with 25 squares:

// 类类型的专属协议
// 你可以在协议的继承列表中，通过添加class关键字来限制协议只能被类类型遵循，而结构体或枚举不能遵循该协议。
// class 关键字必须第一个出现在爱协议的继承列表中，在其他继承的协议之前

protocol SomeClassOnlyProtocol: class, InheritingProtocol {
    // 这里是类类型专属协议的定义部分
}

// 协议SomeClassOnlyProtocol 只能被类类型遵循。如果尝试让结构体或枚举类型遵循改协议。则会导致编译错误。
// 当协议定义的要求需要遵循协议的类型必须是引用语义而非值语义时，应该采用类类型专属协议。

// 协议合成
// 有时候需要同时遵循多个协议，你可以将多个协议采用 SomeProtocol & AnotherProtocol这样的格式进行组合，成为协议合成。

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
// 结构体遵循协议 Named和Aged
struct Human: Named, Aged {
    var name: String
    var age: Int
}

// 这个方法并不关心具体类型，只要遵从这两个协议就行了
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

func wishHappyBirthday(to celebratorName: Named, celebratorAge: Aged) {
    print("Happy birthday, \(celebratorName.name), you're \(celebratorAge.age)!")
}
let birthdayPerson = Human(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)
// Prints "Happy birthday, Malcolm, you're 21!"

// 这里并不关心这个是什么类型、只要他遵循这个协议就可以了
wishHappyBirthday(to: birthdayPerson, celebratorAge: birthdayPerson)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        // 这里是继承的类
        super.init(latitude: latitude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)")
}


let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)
// Prints "Hello, Seattle!"


// MARK: 检查协议的一致性
// 你可以使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议。
// 并且可以转换到指定的协议类型。检查和转换到某个协议类型在语法上和类型的检查和转换完全相同

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double {
        return pi * radius * radius
    }
    
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

// Circle 类把 area 属性实现为基于存储型属性 radius 的计算型属性。Country 类则把 area 属性实现为存储型属性。这两个类都正确地符合了 HasArea 协议。
class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

// 可选的协议要求
// 可选要求用在你需要和 Object-C打交道的代码中
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}
counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}
// -3
// -2
// -1
// 0
// 0

// MARK: 协议扩展
// 协议可以通过扩展来为遵循协议的类型提供属性、方法、以及下标的实现。
// 通过这种实现，你可以基于协议本身来实现这些功能。而无需每个遵循协议的类型中都重复同样的实现，也无需使用全局函数

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

// 通过协议扩展，所有遵循协议的类型，都能自动获得这个扩展所增加的方法实现，无需任何额外修改。
let generator1 = LinearCongruentialGenerator()
print("Here's a random number: \(generator1.random())")
// 打印 “Here's a random number: 0.37464991998171”
print("And here's a random Boolean: \(generator1.randomBool())")
// 打印 “And here's a random Boolean: true”

// MARK: 提供默认实现
// 可以同那个协议扩展来为洗衣要求的属性、方法、下标提供默认的实现。
//如果遵循协议的类型为这些要求提供了自己的实现。那么这些自定义实现将会替代扩展中的默认实现被使用
// 通过协议扩展为协议要求提供的默认实现和可选的协议要求不同。虽然在这两种情况下，遵循协议的类型都无需自己实现这些要求。
// 但是通过扩展提供的默认实现可以直接调用，而不需使用可选链式调用。

extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

// 为协议扩展添加限制条件
// 如果多个协议扩展都为同一个协议要求提供了默认实现，而遵循协议的类型又同时满足这些协议扩展的限制条件，那么将会使用限制条件最多的那个协议扩展提供的默认实现。
extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

print(hamsters.textualDescription)
// 打印 “[A hamster named Murray, A hamster named Morgan, A hamster named Maurice]”


