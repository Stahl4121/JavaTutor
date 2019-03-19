//
//  DataRepo.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/18/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import Foundation

class DataRepo: NSObject {
    let moduleNames = ["NONE","SHALL","PASS"]
    
    static let instance = DataRepo()
    
    private override init() {
        super.init()
    }
}
