//
//  KVOSwiftViewController.swift
//  Expressions_keyPath
//
//  Created by vine on 2019/12/2.
//  Copyright © 2019 vine. All rights reserved.
//

import UIKit

class SomeClass: NSObject {
    @objc var someProperty: Int
    init(someProperty: Int) {
        self.someProperty = someProperty
    }
}

class KVOSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        normalOne()
        normalTwo()
    }
    
    func normalOne() {
        let c = SomeClass(someProperty: 10)
        let pathToProperty = \SomeClass.someProperty
        let value = c[keyPath: pathToProperty]
        print("value:\(value)")

    }
    func normalTwo() {
        let c = SomeClass(someProperty: 10)
        let pathToProperty = \SomeClass.someProperty
        _ =  c.observe(pathToProperty) { object, change in
            
        }
    }
    func normalThree() {
        let c = SomeClass(someProperty: 10)
        _ =  c.observe(\.someProperty) { object, change in
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
