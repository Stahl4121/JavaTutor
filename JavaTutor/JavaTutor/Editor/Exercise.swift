//
//  Exercise.swift
//  JavaTutor
//
//  Created by Sam Carlin on 4/29/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import Foundation

struct Exercise {
    let initial: String
    let output: String
}

extension Exercise {
    init (_ json: [String: Any]) {
        self.initial = json["initial"] as! String
        self.output = json["output"] as! String
    }
}