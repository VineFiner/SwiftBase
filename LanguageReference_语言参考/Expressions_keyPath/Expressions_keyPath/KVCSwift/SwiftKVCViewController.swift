//
//  SwiftKVCViewController.swift
//  Expressions_keyPath
//
//  Created by vine on 2019/12/2.
//  Copyright © 2019 vine. All rights reserved.
//

import UIKit

class SwiftKVCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func normalOne() {
        let s = SomeStructure(someValue: 12)
        let pathToProperty = \SomeStructure.someValue

        let value = s[keyPath: pathToProperty]
        print("value:\(value)")
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
