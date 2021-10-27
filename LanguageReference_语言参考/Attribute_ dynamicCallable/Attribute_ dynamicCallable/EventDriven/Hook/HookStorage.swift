//
//  HookStorage.swift
//  Attribute_ dynamicCallable
//
//  Created by Finer  Vine on 2021/10/17.
//  Copyright © 2021 vine. All rights reserved.
//

import Foundation

public final class HookStorage {
    let wrapper: HookPassthroughWrapper<Any>
    init() {
        self.wrapper = HookPassthroughWrapper<Any>()
    }
}
