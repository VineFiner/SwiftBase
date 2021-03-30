//
//  MyNameSpace.swift
//  OpaqueTypes
//
//  Created by vine on 2020/2/26.
//  Copyright © 2020 Finer  Vine. All rights reserved.
//

import Foundation

struct MyNameSpace<Base> {
 private let base: Base
 init(base: Base) {
    self.base = base
 }
}

extension MyNameSpace {
    func hello() {
        print("hello")
    }
}
protocol NameSpcaceWrappable {
    associatedtype T
    // 变量
    var rx: T { get }
    // 静态变量
    static var rx: T.Type { get }
}

// 扩展
extension NameSpcaceWrappable {
    var rx: MyNameSpace<Self> {
         return MyNameSpace<Self>(base: self)
     }

     static var rx: MyNameSpace<Self>.Type {
         return MyNameSpace<Self>.self
     }
}

extension String: NameSpcaceWrappable {
    
}
