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
    
    var fileUrl: URL?
    
    static let instance = DataRepo()

    private override init() {
        questions = [[Question]]()
        lessonNames = [[String]]()
        super.init()
        
        loadQuestions()
        loadLessonNames()
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
                let questionArray = try JSONSerialization.jsonObject(with: contents, options: .mutableContainers) as! [[String: Any]]

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
