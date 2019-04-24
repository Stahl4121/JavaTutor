//
//  LessonListTVC.swift
//  JavaTutor
//
//  Created by Logan Stahl on 4/12/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class QuizTVC: UITableViewController {
    let repo = DataRepo.instance
    
    var isReviewMode: Bool = false
    var quizTopicName: String = ""
    var numQuestions: Int = 10
    var row: Int = 0
    var module: Int = 0
    
    @IBOutlet weak var lblQuizHeading: UILabel!
    
    override func viewDidLoad() {
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.tableView.rowHeight = UITableView.automaticDimension;
        
        lblQuizHeading.text = "\(quizTopicName) Quiz"
        
        //Shuffle the questions within the module
        repo.questions[module].shuffle()
        
        //Shuffle the answers to every question
        for i in 0...(repo.questions[module].count-1){
            repo.questions[module][i].shuffleAnswers()
        }
        
        //If necessary, lowers the number of questions to the number of available questions
        numQuestions = (repo.questions[module].count < numQuestions) ? repo.questions[module].count : numQuestions
        
        super.viewDidLoad()
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
        return numQuestions
        
        //If you wanted to display every question:
        //return repo.questions[module].count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.questions[module][section].answers.count+1
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
