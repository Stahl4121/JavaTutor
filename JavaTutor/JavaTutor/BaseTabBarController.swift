//
//  BaseTabBarController.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/12/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit
import Firebase


class BaseTabBarController: UITabBarController {
    
    @IBInspectable var defaultIndex: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }
}
