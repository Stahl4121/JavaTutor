//
//  DataRepo.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/18/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import Foundation

class DataRepo: NSObject {
    
    let moduleNames = ["Introduction", "Code Basics", "Control", "Advanced Topics", "Methods and Subroutines"]
    var lessonNames: [[String]]
    var questions: [[Question]]
    
    @objc dynamic var recentActivities: [String]
    
    var username: String
    
    var continueTopic: String
    var improveTopic: String
    var brushUpTopic: String
    
    var fileUrl: URL?
    
    //The index of each array represents the
    //UNNECESSARY
    var correctQuestionsPerModule: [Int]
    var incorrectQuestionsPerModule: [Int]
    
    //INSTEAD, USE:
    var totalQuizzes: Int
    var quizAvg: Double
    var quizzesPerModule: [Int]
    var quizAvgPerMod: [Double]
    var chaptersFinished: [Double]
    
    var bloomsTaxCorrect: [Int]
    var bloomsTaxIncorrect: [Int]
    
    static let instance = DataRepo()

    private override init() {
        questions = [[Question]]()
        lessonNames = [[String]]()
        recentActivities = [String]()
        username = String()
        continueTopic = "No topic has been started."
        improveTopic = String()
        brushUpTopic = String()
        
        //unnecessary
        correctQuestionsPerModule = [0,0,0,0,0,0,0,0,0,0]
        incorrectQuestionsPerModule = [0,0,0,0,0,0,0,0,0,0]
        //instead, make
        quizzesPerModule = [0,0,0,0,0,0,0,0,0,0]
        totalQuizzes = 0
        quizAvg = 0.0
        quizAvgPerMod = [0,0,0,0,0,0,0,0,0,0]
        chaptersFinished = [0,0,0,0,0,0,0,0,0,0]
        
        bloomsTaxCorrect = [Int]()
        bloomsTaxIncorrect = [Int]()
        
        super.init()
        
        addObserver(self, forKeyPath: "recentActivities", options: .new, context: nil)
        
        updateStudyScreenData()
        loadQuestions()
        loadLessonNames()
    }
    
     override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "recentActivities" {
            if !recentActivities.isEmpty {
                continueTopic = recentActivities[0]
            }
        }
    }
    
    func updateStudyScreenData(){
        //TODO: NEED TO GET/CALCULATE THESE
        username = "{Name}"
        improveTopic = "{Topic to be improved}"
        brushUpTopic = "(Topic to be brushed}"
    }
    
    func loadLessonNames(){
        lessonNames.append(["What Makes a Good Program?", "Java Programming Environment"])
        lessonNames.append(["Primitive Data Types", "Char Literals", "String Literals", "Variables", "Operations on a String", "Built in Functions", "Classes and Objects in Java", "I/O", "Basic Output", "Basic Input", "What is an Expression?", "Increment/Decrement", "Relational Operators", "Boolean Operators", "Assignment Operators", "Precedence Rules"])
        lessonNames.append(["What is a Block?", "If Statement", "While Loop", "Do...While Loop", "Break and Continue", "For Loop", "Nested For Loop", "Switch", "Exceptions", "Try...Catch!"])
        lessonNames.append(["What is an Array?", "Creating Arrays", "Arrays and For Loops", "Common Array Pitfalls", "2-Dimensional Arrays"])
        lessonNames.append(["Black Box", "Static Subroutines and Variables", "Subroutine Definitions", "Calling Subroutines", "Subroutines in Programs", "Member Variables", "Formal and Actual Parameters", "Overloading", "Array Parameters", "Command Line Arguments"])
    }
    
    func loadQuestions(){
        var allQuestions = [Question]()
        
        let path = Bundle.main.path(forResource: "questions", ofType: "json")
        if let filePath = path {
            fileUrl = URL(fileURLWithPath: filePath)
        }
        else {
            fileUrl = nil
        }
        
        do {
            if let url = fileUrl {
                // Grab JSON contents
                let contents = try Data(contentsOf: url)
                var questionArray = try JSONSerialization.jsonObject(with: contents, options: .mutableContainers) as! [[String: Any]]
                
                // Add in generated questions
                let qGen = QGen()
                
                for _ in 1...10 {
                    let data = qGen.getQuestion(module: 2).data(using: .utf8)!
                    questionArray.append(try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any])
                }

                // Append each ranking to the array
                for question in questionArray {
                    let temp = Question()
                    
                    for (key, value) in question {
                        if Question.fields.contains(key) {
                            temp.setValue(value, forKey: key)
                        }
                    }
                    
                    temp.shuffleAnswers()
                    allQuestions.append(temp)
                }
                
                // Sort by the specified order
                for i in 1...(moduleNames.count){
                    questions.append(allQuestions.filter({$0.module == i}).shuffled())
                }
                for i in 0...(moduleNames.count-1){
                    if questions[i].isEmpty{
                        questions[i].append(Question(module: i+1, question: "What is the answer to this question?", answers: ["The Correct Answer", "An Incorrect Answer", "Another Incorrect Answer", "Yet Another Incorrect Answer"], correctIdx: 0, bloomValue: 1))
                    }
                }
                
            }
            else {
                print("Bad file path")
            }
        } catch {
            print("Error getting file info")
        }
    }//end loadQuestions()
    

}
