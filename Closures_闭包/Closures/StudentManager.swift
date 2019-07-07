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
    typealias closureBlock = (String) -> Bool
    var nameChangeCallBack: closureBlock?
    // 回调闭包
    var foreignerNameChangeCallBack: ((String, _ last:String) -> Bool)?
    // 回调闭包
    var ageChangeCallBack: ((Int) -> Void)?
    var realAge: Int?
    
    // 调用闭包
    func entryAge(age realAge: Int) {
        ageChangeCallBack?(realAge)
        self.realAge = realAge
    }
    // 调用闭包
    func changeName(name: String) -> Bool{
        var isChange = false
        if let callBack = nameChangeCallBack {
            isChange = callBack(name)
        }
        return isChange
    }
    // 调用闭包
    func foreignerChangeName(first name: String, last: String) -> Bool {
        var isChange = false
        if let callBack = foreignerNameChangeCallBack {
            isChange = callBack(name, last)
        }
        return isChange
    }
}
