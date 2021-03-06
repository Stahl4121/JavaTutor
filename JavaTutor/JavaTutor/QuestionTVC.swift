//
//  LessonListTVC.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/19/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class QuestionTVC: UITableViewController {
    let repo = DomainRepo.instance
    
    var row: Int = 0
    var module: Int = 0
    var selectedQuestion: Int = 0
    var numCorrect: Int = 0
    var numIncorrect: Int = 0
    var tempVal: Int = 0
    
    //Index 0 --> level 1
    //Index 1 --> level 2
    //Index 2 --> level 3
    var bloomCorrectLevels : [Int] = [0, 0, 0]
    var bloomIncorrectLevels : [Int] = [0, 0, 0]
        
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
    
    //Keep calling until the quiz is done, incrementing numCorrect if it matches the corresponding question in the domainRepo
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let child = segue.destination as? QuestionTVC {
            child.module = self.module
            child.selectedQuestion = self.selectedQuestion + 1
            
            //increment correct/incorrect counter
            if repo.questions[module][selectedQuestion].correctIdx == row {
                child.numCorrect = self.numCorrect + 1
                child.numIncorrect = self.numIncorrect
            
                //if they answered it correctly, add the level of Bloom's Taxonomy associated with the question in question (heh)
                
                tempVal = repo.questions[module][selectedQuestion].bloomValue
                child.bloomCorrectLevels[tempVal - 1] = self.bloomCorrectLevels[tempVal - 1] + 1
                child.bloomIncorrectLevels[tempVal - 1] = self.bloomIncorrectLevels[tempVal - 1]
            }
            else{
                child.numIncorrect = self.numIncorrect + 1
                child.numCorrect = self.numCorrect
                
                //add a way to track bloomValueIncorrect
                tempVal = repo.questions[module][selectedQuestion].bloomValue
                child.bloomIncorrectLevels[tempVal - 1] = self.bloomIncorrectLevels[tempVal - 1] + 1
                child.bloomCorrectLevels[tempVal - 1] = self.bloomCorrectLevels[tempVal - 1]
            }
        }
        
        if let child = segue.destination as? QuizResultsVC {
            
            child.moduleNum = self.module
            
            if repo.questions[module][selectedQuestion].correctIdx == row {
                child.numCorrect = self.numCorrect + 1
                child.numIncorrect = self.numIncorrect
                
                
                tempVal = repo.questions[module][selectedQuestion].bloomValue
                child.bloomCorrectLevels[tempVal - 1] = self.bloomCorrectLevels[tempVal - 1] + 1
                
                child.bloomIncorrectLevels[tempVal - 1] = self.bloomIncorrectLevels[tempVal - 1]
                
                
            }
            else{
                child.numIncorrect = self.numIncorrect + 1
                child.numCorrect = self.numCorrect
                
                //add a way to track bloomValueIncorrect
                tempVal = repo.questions[module][selectedQuestion].bloomValue
                
                child.bloomIncorrectLevels[tempVal - 1] = self.bloomIncorrectLevels[tempVal - 1] + 1
                
                child.bloomCorrectLevels[tempVal - 1] = self.bloomCorrectLevels[tempVal - 1]
            }
        }
        
    }
    
}
