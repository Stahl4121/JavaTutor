//
//  LessonListTVC.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/19/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class QuestionTVC: UITableViewController {
    let repo = DataRepo.instance
    
    var row: Int = 0
    var module: Int = 0
    var selectedQuestion: Int = 0
    var numCorrect: Int = 0
    var numIncorrect: Int = 0
        
    @IBOutlet weak var lblQuestionHeading: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    
    override func viewDidLoad() {
        lblQuestionHeading.text = "Question #\(selectedQuestion+1)"
        lblQuestion.text = repo.questions[module][selectedQuestion].question
        repo.questions[module][selectedQuestion].shuffleAnswers()
        
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        row = indexPath.row
        return indexPath
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.questions[module][selectedQuestion].answers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! AnswerCell
        
        cell.lblAnswer.text = "\(repo.questions[module][selectedQuestion].answers[indexPath.row])"
        
        return cell
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        //End quiz at the last question, or after 10 questions
        if selectedQuestion == (repo.questions[module].count - 1) || selectedQuestion == 9 {
            performSegue(withIdentifier: "endQuizSegue", sender: nil)
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let child = segue.destination as? QuestionTVC {
            child.module = self.module
            child.selectedQuestion = self.selectedQuestion + 1
            
            if repo.questions[module][selectedQuestion].correctIdx == row {
                child.numCorrect = self.numCorrect + 1
                child.numIncorrect = self.numIncorrect
            }
            else{
                child.numIncorrect = self.numIncorrect + 1
                child.numCorrect = self.numCorrect
            }
        }
        
        if let child = segue.destination as? QuizResultsVC {
            if repo.questions[module][selectedQuestion].correctIdx == row {
                child.numCorrect = self.numCorrect + 1
                child.numIncorrect = self.numIncorrect
            }
            else{
                child.numIncorrect = self.numIncorrect + 1
                child.numCorrect = self.numCorrect
            }
        }
        
    }
    
}
