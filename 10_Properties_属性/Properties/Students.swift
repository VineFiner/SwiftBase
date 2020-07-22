//
//  Students.swift
//  Properties
//
//  Created by vine on 2018/12/3.
//  Copyright © 2018 Vine. All rights reserved.
//

import Foundation

class Students {
    // 存储属性
    var _name = "Tom"
    // 计算属性
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
}
