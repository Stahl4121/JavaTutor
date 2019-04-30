//
//  ExerciseRunnerVC.swift
//  JavaTutor
//
//  Created by Sam Carlin on 4/29/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class ExerciseRunnerVC: UIViewController {
    
    var sourceCode : String = ""

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var outputText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        JavaRunner.Exec(code: sourceCode) { (result) in
            DispatchQueue.main.sync {
                self.outputText.text = result
                self.spinner.isHidden = true
            }
        }
    }
}
