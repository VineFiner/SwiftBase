//
//  StudentManager.swift
//  Closures
//
//  Created by vine on 2018/12/3.
//  Copyright © 2018 Vine. All rights reserved.
//

import Foundation

class Student {
    // 回调闭包
    typealias closureBlock = (String) -> Void
    var nameChangeCallBack: closureBlock?
    
    // 回调闭包
    var ageChangeCallBack: ((Int) -> Void)?
}
