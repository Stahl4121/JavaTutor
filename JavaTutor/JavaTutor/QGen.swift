//
//  QGen.swift
//  JavaTutor
//
//  Created by Sam Carlin on 3/25/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import Foundation
import JavaScriptCore

public class QGen {
    private let ctx = JSContext()
    private var main = JSValue()
    
    init() {
        if let jsSourcePath = Bundle.main.path(forResource: "index", ofType: "js") {
            do {
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                ctx?.evaluateScript(jsSourceContents)
                main = (ctx?.objectForKeyedSubscript("getQuestion"))!
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getQuestion(module: Int) -> String {
        return (main.call(withArguments: [module])?.toString())!
    }
}
