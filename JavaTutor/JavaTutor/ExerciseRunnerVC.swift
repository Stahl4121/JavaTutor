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
    var exercise: Exercise?

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var outputText: UITextView!
    @IBOutlet weak var expectedOutputText: UITextView!
    @IBOutlet weak var resultText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expectedOutputText.text = exercise!.output

        JavaRunner.Exec(code: sourceCode) { (result) in
            DispatchQueue.main.sync {
                self.outputText.text = result
                self.spinner.isHidden = true
                self.resultText.text = result.contains(self.exercise!.output) ? "Nicely done." : "Hmm, not quite ..."
            }
        }
    }
}
