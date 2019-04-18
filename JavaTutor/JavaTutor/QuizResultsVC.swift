//
//  QuizResultsVC.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/23/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class QuizResultsVC: UIViewController {
    
    let repo = DataRepo.instance
    var moduleNum: Int = 0
    var numCorrect: Int = 0
    var numIncorrect: Int = 0
    var bloomCorrectLevels: [Int] = [0, 0, 0]
    var bloomIncorrectLevels: [Int] = [0, 0, 0]
    
    @IBOutlet weak var lblNumCorrect: UILabel!
    @IBOutlet weak var lblNumIncorrect: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Remove questions from the nav controller, so user cannot re-enter quiz
        var navigationArray = self.navigationController?.viewControllers //To get all UIViewController stack as Array
        for _ in 1...(numCorrect+numIncorrect){
            navigationArray!.remove(at: (navigationArray?.count)! - 2) // To remove previous UIViewController
        }
        self.navigationController?.viewControllers = navigationArray!
        
        
        lblNumCorrect.text = String(numCorrect)
        lblNumIncorrect.text = String(numIncorrect)
        lblScore.text = "\(Int(((Double(numCorrect)/Double(numCorrect+numIncorrect))*100).rounded()))%"
     
        updateDataRepo()
        
    }
    
    
    func updateDataRepo(){
        
        //adjusts correct/incorrect questions (meaningless)
        repo.correctQuestionsPerModule[moduleNum] = repo.correctQuestionsPerModule[moduleNum] + self.numCorrect
        repo.incorrectQuestionsPerModule[moduleNum] = repo.incorrectQuestionsPerModule[moduleNum] + self.numIncorrect
        
        //adjusts correct/incorrect bloom levels (meaningful)
        repo.bloomsTaxCorrect = repo.bloomsTaxCorrect + self.bloomCorrectLevels
        repo.bloomsTaxIncorrect = repo.bloomsTaxIncorrect + self.bloomIncorrectLevels
        
        //increments # of times student has taken this module's quiz.
        repo.totalQuizzes = repo.totalQuizzes + 1
        
        //adjusts quiz average: (All prev * (new_total - 1) + new_Score )/new_total
        repo.quizAvg = ((repo.quizAvg * Double((repo.totalQuizzes - 1))) + ((Double(numCorrect)/Double(numCorrect+numIncorrect))*100))/(Double(repo.totalQuizzes))
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
