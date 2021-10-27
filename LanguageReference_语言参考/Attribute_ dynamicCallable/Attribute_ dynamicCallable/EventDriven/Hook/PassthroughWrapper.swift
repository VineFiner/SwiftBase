//
//  PassthroughWrapper.swift
//  Attribute_ dynamicCallable
//
//  Created by Finer  Vine on 2021/10/17.
//  Copyright © 2021 vine. All rights reserved.
//

import Foundation

// 动态成员查找, 透传包装
@dynamicMemberLookup
struct HookPassthroughWrapper<Value> {
    var value: Value
    subscript<T>(dynamicMember member: KeyPath<Value, T>) -> T {
        get { return value[keyPath: member] }
    }
}
