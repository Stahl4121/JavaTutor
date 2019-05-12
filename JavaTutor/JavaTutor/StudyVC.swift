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
    
    var lowScoreIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentRepo.addObserver(self, forKeyPath: "recentActivities", options: .new, context: nil)
        
        viewLoadSetup()
    }
    
    func viewLoadSetup() {
        
        lowScoreIndex = findLowestScore()
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
    
    func findLowestScore() -> Int {
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
        
        lowScoreIndex = findLowestScore()
        
        if let child = segue.destination as? LessonListTVC {
            child.module = lowScoreIndex
            
            //Update recent activities list
            if let index = studentRepo.recentActivities.firstIndex(of: domainRepo.moduleNames[lowScoreIndex]){
                studentRepo.recentActivities.remove(at: index)
            }
            studentRepo.recentActivities.insert(domainRepo.moduleNames[lowScoreIndex], at: 0)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    
    
}
