//
//  DataRepo.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/18/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import Foundation

class DataRepo: NSObject {
    
    let moduleNames = ["Module One Name","Module Two Name"]
    var lessonNames: [[String]]
    var questions: [[Question]]
    
    @objc dynamic var recentActivities: [String]
    
    var username: String
    
    var continueTopic: String
    var improveTopic: String
    var brushUpTopic: String
    
    var fileUrl: URL?
    
    static let instance = DataRepo()

    private override init() {
        questions = [[Question]]()
        lessonNames = [[String]]()
        recentActivities = [String]()
        username = String()
        continueTopic = "No topic has been started."
        improveTopic = String()
        brushUpTopic = String()
        
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
        lessonNames.append(["The Venerable \"Hello World\"","This! That!","The Other Thing"])
        lessonNames.append(["Mod2Les1","Mod2Les2","Mod2Les3"])
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
            }
            else {
                print("Bad file path")
            }
        } catch {
            print("Error getting file info")
        }
    }
}
