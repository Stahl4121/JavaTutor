//
//  StudyVC.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/11/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class StudyVC: UIViewController {
    let studentRepo = StudentRepo.instance
    let domainRepo = DomainRepo.instance
    
    @IBOutlet weak var lblContinueTopic: UILabel!
    @IBOutlet weak var lblImproveTopic: UILabel!
    @IBOutlet weak var lblBrushTopic: UILabel!
    @IBOutlet weak var lblWelcomeBack: UILabel!
    
    var continueIndex : Int = 0
    var lowScoreIndex : Int = 0
    var brushUpIndex : Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentRepo.addObserver(self, forKeyPath: "recentActivities", options: .new, context: nil)
        
        viewLoadSetup()
    }
    
    func viewLoadSetup() {
        
        lowScoreIndex = findLowestScoreIndex()
        lblContinueTopic.text = studentRepo.continueTopic
        lblImproveTopic.text = domainRepo.moduleNames[lowScoreIndex]
        lblWelcomeBack.text = "Welcome back, \(studentRepo.username)!"
        if studentRepo.recentActivities.count > 0 {
            lblBrushTopic.text = studentRepo.recentActivities[studentRepo.recentActivities.count - 1]
        } else {
            lblBrushTopic.text = "No topic has been started."
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !studentRepo.recentActivities.isEmpty {
            lblContinueTopic.text = studentRepo.recentActivities[0]
        }
    }
    
    
    func findContinueIndex() -> Int {
        if studentRepo.recentActivities.count > 0 {
            let stringToMatch = studentRepo.recentActivities[0]
            for (i, s) in domainRepo.moduleNames.enumerated() {
                if s == stringToMatch {
                    return i
                }
            }
        }
        return 0
    }
    
    
    func findBrushUpIndex() -> Int {
        if studentRepo.recentActivities.count > 0 {
            
            let stringToMatch = studentRepo.recentActivities[studentRepo.recentActivities.count - 1]
            
            for (i, m) in domainRepo.moduleNames.enumerated() {
                if m == stringToMatch {
                    return i
                }
            }
        }
        return 0
    }
    
    
    func findLowestScoreIndex() -> Int {
        var minScore = 100.0
        var indexOfMin = 0
        
        for (i, s) in studentRepo.quizAvgPerMod.enumerated() {
            if s < minScore && s != 0 {
                minScore = s
                indexOfMin = i
            }
        }
        return indexOfMin
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        continueIndex = findContinueIndex()
        brushUpIndex = findBrushUpIndex()
        lowScoreIndex = findLowestScoreIndex()
     
        if segue.identifier == "continue" {
            if let child = segue.destination as? LessonListTVC {
                if studentRepo.recentActivities.count > 0 {
                    child.module = continueIndex
                    updateRecentActivities(sentIndex: continueIndex)
                } else {
                    child.module = 0
                    updateRecentActivities(sentIndex: 0)
                }
            }
        } else if segue.identifier == "brush" {
            if let child = segue.destination as? LessonListTVC {
                if studentRepo.recentActivities.count > 0 {
                    child.module = brushUpIndex
                    updateRecentActivities(sentIndex: brushUpIndex)
                } else {
                    child.module = 0
                    updateRecentActivities(sentIndex: 0)
                }
            }
        } else if segue.identifier == "improvement" {
            if let child = segue.destination as? LessonListTVC {
                child.module = lowScoreIndex
                updateRecentActivities(sentIndex: lowScoreIndex)
            }
        }
    }

    /*
     * Update recent activities list
     */
    func updateRecentActivities(sentIndex: Int){
        if let index = studentRepo.recentActivities.firstIndex(of: domainRepo.moduleNames[sentIndex]){
            studentRepo.recentActivities.remove(at: index)
        }
        studentRepo.recentActivities.insert(domainRepo.moduleNames[sentIndex], at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    
    
}
