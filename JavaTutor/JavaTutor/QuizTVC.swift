//
//  LessonListTVC.swift
//  JavaTutor
//
//  Created by Logan Stahl on 4/12/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class QuizTVC: UITableViewController {
    let repo = DomainRepo.instance
    
    var isReviewMode: Bool = false
    var reviewIdxPaths: [IndexPath] = [IndexPath]()
    
    var numQuestions: Int = 10
    var row: Int = 0
    var module: Int = 0
    
    @IBOutlet weak var lblQuizHeading: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Forces the view hierarchy to load
        _ = self.view

        if isReviewMode {
            lblQuizHeading.text = "\(repo.moduleNames[module]) Quiz Review"
            tableView.allowsSelection = false
        }
        else{
            self.tableView.allowsMultipleSelection = true
            self.tableView.allowsMultipleSelectionDuringEditing = true
            self.tableView.rowHeight = UITableView.automaticDimension
            
            lblQuizHeading.text = "\(repo.moduleNames[module]) Quiz"
            
            //Shuffle the questions within the module
            repo.questions[module].shuffle()
            
            //Shuffle the answers to every question
            for i in 0...(repo.questions[module].count-1){
                repo.questions[module][i].shuffleAnswers()
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            for selectedIndexPath in selectedIndexPaths {
                if selectedIndexPath.section == indexPath.section {
                    tableView.deselectRow(at: selectedIndexPath, animated: true)
                }
            }
        }
        return indexPath
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        //If necessary, lowers the number of questions to the number of available questions
        numQuestions = (repo.questions[module].count < numQuestions) ? repo.questions[module].count : numQuestions
        return numQuestions
        
        //If you wanted to display every question:
        //return domainRepo.questions[module].count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.questions[module][section].answers.count+1
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = cell.contentView.backgroundColor
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currQuestion = repo.questions[module][indexPath.section]
        
        //If the cell should be the question header
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "questionHeaderCell", for: indexPath) as! QuestionHeaderCell
            
            cell.lblQuestionTitle.text = "\(currQuestion.question)"
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! AnswerCell
            
            cell.lblAnswer.text = "\(currQuestion.answers[indexPath.row-1])"
            
            //If this screen is being displayed in review mode, color the right/wrong answers
            if isReviewMode {
                //Get the user's answer for the question
                let userAnswer = reviewIdxPaths.filter({$0.section == indexPath.section}).first
                
                cell.contentView.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.9607843137, blue: 0.8823529412, alpha: 1)
                
                //If this cell was selected, then turn it red
                if indexPath.row == userAnswer?.row {
                    cell.contentView.backgroundColor = UIColor.red
                }
                
                //If it was instead the correct answer, turn it green
                if indexPath.row - 1 == currQuestion.correctIdx {
                    cell.contentView.backgroundColor = UIColor.green
                }
            }
            
            return cell
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        //Prevent ending the quiz if the user hasn't answered every question
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            if selectedIndexPaths.count != numQuestions {
                
                let alert = UIAlertController(title: "Whoops!", message: "Make sure you answer every question before submitting the quiz!", preferredStyle: UIAlertController.Style.alert)
                
                let alertAction = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default)
                {
                    (UIAlertAction) -> Void in
                }
                
                alert.addAction(alertAction)
                
                present(alert, animated: true)
                {
                    () -> Void in
                }
                
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let child = segue.destination as? QuizResultsVC {
            child.moduleNum = self.module
            
            if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
                child.quizSubmittedIdxPaths = selectedIndexPaths
            }
        }
    }
}
