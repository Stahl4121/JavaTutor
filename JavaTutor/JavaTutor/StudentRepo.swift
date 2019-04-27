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
    
    var username: String
    var continueTopic: String
    var improveTopic: String
    var brushUpTopic: String
    var fileUrl: URL?
    
    var totalQuizzes: Int
    var quizAvg: Double
    var quizzesPerModule: [Int]
    var quizAvgPerMod: [Double]
    var chaptersFinished: [Double]
    
    var bloomsTaxCorrect: [Int]
    var bloomsTaxIncorrect: [Int]
    
    static let instance = StudentRepo()
    
    private override init() {
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
        
        updateStudyScreenData()
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
    
}
