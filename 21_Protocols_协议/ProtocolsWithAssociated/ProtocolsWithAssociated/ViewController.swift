//
//  ViewController.swift
//  ProtocolsWithAssociated
//
//  Created by vine on 2020/4/26.
//  Copyright © 2020 vine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func userInfo() {
        let manager = DataManager()
        manager.fetchUser()
    }
}

