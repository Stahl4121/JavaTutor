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
    var quizSubmittedIdxPaths: [IndexPath] = [IndexPath]()
    
    var numCorrect: Int = 0
    var numIncorrect: Int = 0
    var bloomCorrectLevels: [Int] = [0, 0, 0]
    var bloomIncorrectLevels: [Int] = [0, 0, 0]
    
    @IBOutlet weak var lblNumCorrect: UILabel!
    @IBOutlet weak var lblNumIncorrect: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Remove quiz screen from the nav controller, so user cannot re-enter quiz
        var navigationArray = self.navigationController?.viewControllers //To get all UIViewController stack as Array
        navigationArray!.remove(at: (navigationArray?.count)! - 2) // To remove previous UIViewController
        self.navigationController?.viewControllers = navigationArray!
        
        gradeQuiz()
        
        lblNumCorrect.text = String(numCorrect)
        lblNumIncorrect.text = String(numIncorrect)
        lblScore.text = "\(Int(((Double(numCorrect)/Double(numCorrect+numIncorrect))*100).rounded()))%"
     
        updateDataRepo()
    }
    
    func gradeQuiz(){
        //Check every question's answer
        for idxPath in quizSubmittedIdxPaths {
            let bloomVal = repo.questions[moduleNum][idxPath.section].bloomValue

                //Correct Question
                if repo.questions[moduleNum][idxPath.section].correctIdx == (idxPath.row - 1) {
                    numCorrect+=1
                    bloomCorrectLevels[bloomVal - 1] += 1
                }
                else{ //Incorrect Question
                    numIncorrect+=1
                    bloomIncorrectLevels[bloomVal - 1] += 1
                }
        }
    }
    
    func updateDataRepo(){
        
        //adjusts correct/incorrect questions (meaningless)
        repo.correctQuestionsPerModule[moduleNum] = repo.correctQuestionsPerModule[moduleNum] + self.numCorrect
        repo.incorrectQuestionsPerModule[moduleNum] = repo.incorrectQuestionsPerModule[moduleNum] + self.numIncorrect
        
        //adjusts correct/incorrect bloom levels (meaningful)
        repo.bloomsTaxCorrect = repo.bloomsTaxCorrect + self.bloomCorrectLevels
        repo.bloomsTaxIncorrect = repo.bloomsTaxIncorrect + self.bloomIncorrectLevels
        
        //increments # of times student has taken a quiz
        repo.totalQuizzes = repo.totalQuizzes + 1
        
        //adjusts OVERALL quiz average: (All prev * (new_total - 1) + new_Score )/new_total
        repo.quizAvg = ((repo.quizAvg * Double((repo.totalQuizzes - 1))) + ((Double(numCorrect)/Double(numCorrect+numIncorrect))*100))/(Double(repo.totalQuizzes))
        
        //adjusts quiz average & attempt count for this module
        repo.quizzesPerModule[moduleNum] = repo.quizzesPerModule[moduleNum] + 1
        repo.quizAvgPerMod[moduleNum] = ((repo.quizAvgPerMod[moduleNum] * Double((repo.quizzesPerModule[moduleNum] - 1))) + ((Double(numCorrect)/Double(numCorrect+numIncorrect))*100))/(Double(repo.quizzesPerModule[moduleNum]))
        
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let child = segue.destination as? QuizTVC {
            child.isReviewMode = true
            child.reviewIdxPaths = quizSubmittedIdxPaths
            child.module = moduleNum
        }
     }
    
}
