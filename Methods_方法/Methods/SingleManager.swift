//
//  SingleManager.swift
//  Methods
//
//  Created by vine on 2018/12/3.
//  Copyright © 2018 Vine. All rights reserved.
//

import Foundation

class StudentManager {
    // 这里是一个闭包
    static let shareManager: StudentManager = {
        let instance = StudentManager()
        // setup code
        return instance
    }()
}

class ManagerOne {
    static let shared = ManagerOne()
    private init() {
        // setup code
    }
}
