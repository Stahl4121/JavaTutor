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
   
    let fileURL: URL
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
        
        bloomsTaxCorrect = [0,0,0]
        bloomsTaxIncorrect = [0,0,0]
        
        
        let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        fileURL = URL(fileURLWithPath: libraryPath).appendingPathComponent("students.json")
        
        //Copy the initial file from the bundle if it
        //does not yet exist in the library directory.
        if !FileManager.default.fileExists(atPath: fileURL.path){
            do {
                let path = Bundle.main.path(forResource: "students", ofType: "json")
                let bundleFileURL = URL(fileURLWithPath: path!)
                let contents = try Data(contentsOf: bundleFileURL)
                try contents.write(to: fileURL)
            } catch{
                print("Error creating initial file students.json")
            }
        }
        
        super.init()
        
        //Add an observer to every member variable, to keep local file storage updated
        for key in fields{
            addObserver(self, forKeyPath: key, options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //Update RecentActivities list
        if keyPath == "recentActivities" {
            if !recentActivities.isEmpty {
                continueTopic = recentActivities[0]
            }
        }

        //Write new changes to local file storage
        writeLocalStudent()
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
        do {
                // Grab JSON contents
                let contents = try Data(contentsOf: fileURL)
                let students = try JSONSerialization.jsonObject(with: contents, options: .mutableContainers) as! [[String: Any]]
                print("STUDENTS LOADING\n")
                print(students)
            
                for stud in students {
                    //Find the current user in local data
                    if stud["username"] as! String == self.username {
                        for (key, value) in stud {
                            if fields.contains(key) {
                                StudentRepo.instance.setValue(value, forKey: key)
                            }
                        }
                    }
            }
        } catch {
            print("Error getting file info for students.json")
        }
    }
    
    /**
     * Updates the local file with the newest student information
    */
    func writeLocalStudent(){
        // Grab current JSON contents
        do {
            let contents = try Data(contentsOf: fileURL)
            var students = try JSONSerialization.jsonObject(with: contents, options: .mutableContainers) as! [[String: Any]]
            
            //Remove the current student's old data from the json
            students.removeAll(where: {($0["username"] as! String) == self.username})
            
            let currentUserData: [String:Any] = [
                "username":self.username,
                "recentActivities":self.recentActivities,
                "totalQuizzes":self.totalQuizzes,
                "quizAvg":self.quizAvg,
                "quizzesPerModule":self.quizzesPerModule,
                "quizAvgPerMod":self.quizAvgPerMod,
                "chaptersFinished":self.chaptersFinished,
                "bloomsTaxCorrect":self.bloomsTaxCorrect,
                "bloomsTaxIncorrect":self.bloomsTaxIncorrect
            ]
            
            //Add the current student back into the json
            students.append(currentUserData)
            
            print("STUDENTS WRITING\n")
            print(students)
            
            let jsonData = try JSONSerialization.data(withJSONObject: students, options: .prettyPrinted)
            try jsonData.write(to: fileURL)
        } catch {
            print("Failed to write")
        }
    }
    
    //Deinitialize the repo by writing the data to json, and removing all observers
    deinit{
        for key in fields {
            self.removeObserver(self, forKeyPath: key)
        }
        
        writeLocalStudent()
    }
    
}
