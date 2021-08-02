//
//  Card.swift
//  ClassesAndStructures
//
//  Created by Finer  Vine on 2021/6/6.
//  Copyright © 2021 Vine. All rights reserved.
//

import Foundation

struct Card : Hashable {
    
    var hashValue: Int {
        return identifier
    }
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    /// 已经翻牌
    var isFaceUp = false
    /// 已经匹配
    var isMatched = false
    /// 这里是下标
    private var identifier: Int
    
    private static var identifierFactory = 0
    // 获取唯一的下标
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
