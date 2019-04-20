//
//  QuizProgressVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 4/18/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class QuizProgressVC: UIViewController {

    
    let repo = DataRepo.instance
    
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
    
    
    func viewLoadSetup() {
        
        mod1attempts.text = "\(repo.quizzesPerModule[0])"
        mod2attempts.text = "\(repo.quizzesPerModule[1])"
        mod3attempts.text = "\(repo.quizzesPerModule[2])"
        mod4attempts.text = "\(repo.quizzesPerModule[3])"
        mod5attempts.text = "\(repo.quizzesPerModule[4])"
        mod6attempts.text = "\(repo.quizzesPerModule[5])"
        mod7attempts.text = "\(repo.quizzesPerModule[6])"
        mod8attempts.text = "\(repo.quizzesPerModule[7])"
        mod9attempts.text = "\(repo.quizzesPerModule[8])"
        mod10attempts.text = "\(repo.quizzesPerModule[9])"
        
        mod1score.text = "\(repo.quizAvgPerMod[0].rounded())"
        mod2score.text = "\(repo.quizAvgPerMod[1].rounded())"
        mod3score.text = "\(repo.quizAvgPerMod[2].rounded())"
        mod4score.text = "\(repo.quizAvgPerMod[3].rounded())"
        mod5score.text = "\(repo.quizAvgPerMod[4].rounded())"
        mod6score.text = "\(repo.quizAvgPerMod[5].rounded())"
        mod7score.text = "\(repo.quizAvgPerMod[6].rounded())"
        mod8score.text = "\(repo.quizAvgPerMod[7].rounded())"
        mod9score.text = "\(repo.quizAvgPerMod[8].rounded())"
        mod10score.text = "\(repo.quizAvgPerMod[9].rounded())"
        
        //"\(Int(((Double(numCorrect)/Double(numCorrect+numIncorrect))*100).rounded()))%"
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoadSetup()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    

}
