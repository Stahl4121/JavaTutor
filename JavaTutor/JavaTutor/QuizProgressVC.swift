//
//  QuizProgressVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 4/18/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class QuizProgressVC: UIViewController {

    
    let studentRepo = StudentRepo.instance
    
    @IBOutlet weak var mod1attempts: UILabel!
    @IBOutlet weak var mod2attempts: UILabel!
    @IBOutlet weak var mod3attempts: UILabel!
    @IBOutlet weak var mod4attempts: UILabel!
    @IBOutlet weak var mod5attempts: UILabel!
    @IBOutlet weak var mod6attempts: UILabel!
    @IBOutlet weak var mod7attempts: UILabel!
    @IBOutlet weak var mod8attempts: UILabel!
    @IBOutlet weak var mod9attempts: UILabel!
    @IBOutlet weak var mod10attempts: UILabel!
    
    var modAttemptsArray : [UILabel]!
    
    @IBOutlet weak var mod1score: UILabel!
    @IBOutlet weak var mod2score: UILabel!
    @IBOutlet weak var mod3score: UILabel!
    @IBOutlet weak var mod4score: UILabel!
    @IBOutlet weak var mod5score: UILabel!
    @IBOutlet weak var mod6score: UILabel!
    @IBOutlet weak var mod7score: UILabel!
    @IBOutlet weak var mod8score: UILabel!
    @IBOutlet weak var mod9score: UILabel!
    @IBOutlet weak var mod10score: UILabel!
    
    var modScoresArray : [UILabel]!
    
    func viewLoadSetup() {
      
        for i in 0...9 {
            modAttemptsArray[i].text = "\(studentRepo.quizzesPerModule[i])"
        }
    
        for i in 0...9 {
            modScoresArray[i].text = "\(studentRepo.quizAvgPerMod[i].rounded())"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modAttemptsArray = [mod1attempts, mod2attempts, mod3attempts, mod4attempts, mod5attempts, mod6attempts, mod7attempts, mod8attempts, mod9attempts, mod10attempts]
        modScoresArray = [mod1score, mod2score, mod3score, mod4score, mod5score, mod6score, mod7score, mod8score, mod9score, mod10score]
        
        viewLoadSetup()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    

}
