//
//  StudentRepo.swift
//  JavaTutor
//
//  Created by Logan Stahl on 4/27/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import Foundation

class StudentRepo: NSObject {
    @objc dynamic var recentActivities: [String]
    
    var isOnlineMode: Bool
    
    var username: String
    var continueTopic: String
    var improveTopic: String
    var brushUpTopic: String
    var fileUrl: URL?
    
    let fields = ["totalQuizzes", "quizAvg", "quizzesPerModule", "quizAvgPerMod", "chaptersFinished", "bloomsTaxCorrect", "bloomsTaxIncorrect", "recentActivities"]
    
    @objc var totalQuizzes: Int
    @objc var quizAvg: Double
    @objc var quizzesPerModule: [Int]
    @objc var quizAvgPerMod: [Double]
    @objc var chaptersFinished: [Double]
    
    @objc var bloomsTaxCorrect: [Int]
    @objc var bloomsTaxIncorrect: [Int]
    
    static let instance = StudentRepo()
    
    private override init() {
        isOnlineMode = false
        
        username = String()
        recentActivities = [String]()
        continueTopic = "No topic has been started."
        improveTopic = String()
        brushUpTopic = String()
        
        quizzesPerModule = [0,0,0,0,0,0,0,0,0,0]
        totalQuizzes = 0
        quizAvg = 0.0
        quizAvgPerMod = [0,0,0,0,0,0,0,0,0,0]
        chaptersFinished = [0,0,0,0,0,0,0,0,0,0]
        
        bloomsTaxCorrect = [Int]()
        bloomsTaxIncorrect = [Int]()
        
        super.init()
        
        addObserver(self, forKeyPath: "recentActivities", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "recentActivities" {
            if !recentActivities.isEmpty {
                continueTopic = recentActivities[0]
            }
        }
    }
    
    func initAfterLogin(username: String){
        self.username = username
        
        if isOnlineMode {
            //Update Repo from Database
        }
        else{
            //Update Repo from students.json
            loadLocalStudent()
        }
        
        updateStudyScreenData()
    }
    
    func updateStudyScreenData(){
        //TODO: NEED TO GET/CALCULATE THESE
        improveTopic = "{Topic to be improved}"
        brushUpTopic = "(Topic to be brushed}"
    }
    
    /**
     * Populates the StudentRepo member variables from
     * the students.json file.
     */
    func loadLocalStudent(){
        let path = Bundle.main.path(forResource: "students", ofType: "json")
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
                let students = try JSONSerialization.jsonObject(with: contents, options: .mutableContainers) as! [[String: Any]]
                
                for stud in students {
                    //Find the current user in local data
                    if stud["username"] as! String == self.username {
                        for (key, value) in stud {
                            if StudentRepo.instance.fields.contains(key) {
                                StudentRepo.instance.setValue(value, forKey: key)
                            }
                        }
                    }
                }
            }
            else {
                print("Bad file path to students.json")
            }
        } catch {
            print("Error getting file info for students.json")
        }
    }
    
}
