//
//  MyPropertyWrappers.swift
//  Properties
//
//  Created by vine on 2020/2/26.
//  Copyright © 2020 Vine. All rights reserved.
//

import Foundation

class MyPropertyWrappers {
    func test() {
        // MARK: Property Wrappers
        // Playground

        //  属性包装
        struct TwelveOrLess {
            private var number = 0
            // 必须实现，相当于，设置找个值，获取这个值
            var wrappedValue: Int {
                get { return number }
                set { number = min(newValue, 12) }
            }
        }

        // 显示使用
        struct SmallRectangleExplicitly {
            private var _height = TwelveOrLess()
            private var _width = TwelveOrLess()
            var height: Int {
                get { return _height.wrappedValue }
                set { _height.wrappedValue = newValue }
            }
            var width: Int {
                get { return _width.wrappedValue }
                set { _width.wrappedValue = newValue }
            }
        }

        // MARK: Setting Initial Values for Wrapped Properties
        @propertyWrapper
        struct SmallNumber {
            private var maximum: Int
            private var number: Int

            var wrappedValue: Int {
                get { return number }
                set { number = min(newValue, maximum) }
            }

            init() {
                maximum = 12
                number = 0
            }
            init(wrappedValue: Int) {
                maximum = 12
                number = min(wrappedValue, maximum)
            }
            // 可以使用这个进行初始化
            init(wrappedValue: Int, maximum: Int) {
                self.maximum = maximum
                number = min(wrappedValue, maximum)
            }
        }

         struct ZeroRectangle {
             @SmallNumber var height: Int
             @SmallNumber var width: Int
         }
         
         var zeroRectangle = ZeroRectangle()
         print(zeroRectangle.height, zeroRectangle.width)
         // Prints "0 0"
        zeroRectangle.height = 3
        print(zeroRectangle.height, zeroRectangle.width)


        struct UnitRectangle {
            @SmallNumber var height: Int = 1
            @SmallNumber var width: Int = 1
        }

        var unitRectangle = UnitRectangle()
        print(unitRectangle.height, unitRectangle.width)
        // Prints "1 1"
        unitRectangle.height = 5
        print(unitRectangle.height, unitRectangle.width)

        // 可以接受外部参数
        struct NarrowRectangle {
            @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
            @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
            @SmallNumber(wrappedValue: 2, maximum: 5) var length: Int
        }

        var narrowRectangle = NarrowRectangle()
        print(narrowRectangle.height, narrowRectangle.width)
        // Prints "2 3"
        print(narrowRectangle.length)
        //print("2")

        narrowRectangle.height = 100
        narrowRectangle.width = 100
        print(narrowRectangle.height, narrowRectangle.width)
        // Prints "5 4"

        // 通过赋值，指定初始值
        struct MixedRectangle {
            @SmallNumber var height: Int = 1
            // error Incorrect argument label in call (have 'maximum:', expected 'wrappedValue:')
            // 参数标签不正确
            // @SmallNumber(maximum: 9) var width: Int
            // error Cannot invoke initializer for type 'SmallNumber' with an argument list of type '(wrappedValue: Int, wrappedValue: Int, maximum: Int)'
            // 不能够初始化，三个参数的 的 SmallNUmber
            // @SmallNumber(wrappedValue: 2, maximum: 9) var width: Int = 3
            // 正确初始化两个参数
            @SmallNumber(maximum: 9) var width: Int = 2
        }

        var mixedRectangle = MixedRectangle()
        print(mixedRectangle.height, mixedRectangle.width)
        // Prints "1 2"

        mixedRectangle.height = 20
        mixedRectangle.width = 20
        print(mixedRectangle.height, mixedRectangle.width)
        // Prints "12 9"

        // MARK: 映射

        @propertyWrapper
        struct ProjectingSmallNumber {
            private var number = 0
            // 这里是固定值，不能改变, 但是类型不定
            var projectedValue = false
            // 这里也是固定值，不能改变, 但是类型不定
            var wrappedValue: Int {
                get { return number }
                set {
                    if newValue > 12 {
                        number = 12
                        projectedValue = true
                    } else {
                        number = newValue
                        projectedValue = false
                    }
                }
            }
        }
        struct ProjectingSomeStructure {
            @ProjectingSmallNumber var someNumber: Int
        }
        var someStructure = ProjectingSomeStructure()

        someStructure.someNumber = 4
        print(someStructure.$someNumber)
        // Prints "false"

        someStructure.someNumber = 55
        print(someStructure.$someNumber)
        // Prints "true"

        enum ProjectingSize {
            case small, large
        }

        struct ProjectingSizedRectangle {
            @ProjectingSmallNumber var height: Int
            @ProjectingSmallNumber var width: Int

            mutating func resize(to size: ProjectingSize) -> Bool {
                switch size {
                case .small:
                    height = 10
                    width = 20
                case .large:
                    height = 100
                    width = 100
                }
                return $height || $width
            }
        }
    }
}
