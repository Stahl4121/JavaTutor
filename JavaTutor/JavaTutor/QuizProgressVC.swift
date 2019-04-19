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
    
    @IBOutlet weak var mod1score: UILabel!
    
    @IBOutlet weak var mod2score: UILabel!
    
    @IBOutlet weak var mod3score: UILabel!
    
    @IBOutlet weak var mod4score: UILabel!
    
    @IBOutlet weak var mod5score: UILabel!
    
    
    
    func viewLoadSetup() {
        
        mod1attempts.text = "\(repo.quizzesPerModule[0])"
        mod2attempts.text = "\(repo.quizzesPerModule[1])"
        mod3attempts.text = "\(repo.quizzesPerModule[2])"
        mod4attempts.text = "\(repo.quizzesPerModule[3])"
        mod5attempts.text = "\(repo.quizzesPerModule[4])"
        
        mod1score.text = "\(repo.quizAvgPerMod[0].rounded())"
        mod2score.text = "\(repo.quizAvgPerMod[1].rounded())"
        mod3score.text = "\(repo.quizAvgPerMod[2].rounded())"
        mod4score.text = "\(repo.quizAvgPerMod[3].rounded())"
        mod5score.text = "\(repo.quizAvgPerMod[4].rounded())"
        
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
