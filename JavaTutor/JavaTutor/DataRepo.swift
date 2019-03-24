//
//  DataRepo.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/18/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import Foundation

class DataRepo: NSObject {
    var moduleNames = ["NONE","SHALL","PASS"]
    
    var lessonNames: [[String]] { get {
        var names = [[String]]()
        names.append(["The Venerable \"Hello World\"","This! That!","The Other Thing"])
        names.append([])
        
        return names
        }}
    
    var questions: [[Question]] {get {
        var q = [[Question]]()
        q.append([Question(data: ["Mod1Question1","CorAns","Ans2","Ans3","Ans4"]),Question(data: ["Mod1Question2","CorAns","Ans2","Ans3","Ans4"])])
        
        q.append([Question(data: ["Mod2Question1","CorAns","Ans2","Ans3","Ans4"]),Question(data: ["Mod2Question2","CorAns","Ans2","Ans3","Ans4"])])

        return q
        
        }}
    
    static let instance = DataRepo()
    
    private override init() {
        super.init()
    }
}
