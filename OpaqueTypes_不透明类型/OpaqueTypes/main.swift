//
//  main.swift
//  OpaqueTypes
//
//  Created by Finer  Vine on 2019/6/7.
//  Copyright © 2019 Finer  Vine. All rights reserved.
//

import Foundation

print("Hello, World!")

// 形状协议
protocol Shape {
    func draw() -> String
}

// 三角形
struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result = [String]()
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}

let smallTriangle = Triangle(size: 3)
print(smallTriangle.draw())

// 翻转形状
struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}

let flippedTriangle = FlippedShape(shape: smallTriangle)
print(flippedTriangle.draw())

// 两个形状连接
// 泛型 T、泛型 U、 遵从协议 Shape
struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}

let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
print(joinedTriangles.draw())

// 隐式类型
// 正方形
struct Square: Shape {
    var size: Int
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        //
//        let result = Array(repeating: line, count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}

func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
    return trapezoid
}
let trapezoid = makeTrapezoid()
print(trapezoid.draw())


//func flip<T: Shape>(_ shape: T) -> some Shape {
//    return FlippedShape(shape: shape)
//}
//func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
//    JoinedShape(top: top, bottom: bottom)
//}
//
//let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
//print(opaqueJoinedTriangles.draw())


//func invalidFlip<T: Shape>(_ shape: T) -> Shape {
//    if shape is Square {
//        return shape // Error: return types don't match
//    }
//    return FlippedShape(shape: shape) // Error: return types don't match
//}
