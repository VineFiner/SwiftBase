//
//  ControlFlow.swift
//  CollectionTypes
//
//  Created by vine on 2019/4/23.
//  Copyright © 2019 Vine. All rights reserved.
//
// 高级运算符

import Foundation

struct Advanced {
    
    func test() {
        ///原来类型： Int?,返回值类型：String?
        let value:Int? = 1
        let result = value.map { String("result = \($0)") }
        /// "Optional("result = 1")"
        print(result ?? "")
        
        // 这里是过滤
        let values = [1,3,5,7,9]
        let flattenResults = values.filter{ $0 % 3 == 0}
        //[3, 9]
        print(flattenResults)
        
        let items = [[1,2,3],[4,5,6,7]]
        items.filter { $0.count % 3 == 0 }.forEach { show($0)}
        
        let chained = items.filter { $0.count % 3 == 0 }
        /// 这里是过滤得到的值
        print("This is result:\(chained)")
        chained.forEach { show($0)}
    }
    func show(_ item: [Int]) {
        print("item:\(item)")
    }
}
