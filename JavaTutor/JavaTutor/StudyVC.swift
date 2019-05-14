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
    
    var segueIdxModule : Int = 0
    var segueIdxLesson : Int = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentRepo.addObserver(self, forKeyPath: "recentActivities", options: .new, context: nil)
        
        viewLoadSetup()
    }
    
    func viewLoadSetup() {
        
        lblContinueTopic.text = studentRepo.continueTopic
        lblImproveTopic.text = domainRepo.moduleNames[findLowestScoreIndex()]
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
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier != "toModuleCatalogSegue"{
            if studentRepo.recentActivities.count > 0 {
                if identifier == "continue" {
                    let idxTuple = domainRepo.findModuleLessonIndices(str: studentRepo.recentActivities[0])
                    (segueIdxModule, segueIdxLesson) = idxTuple
                }
                else if identifier == "brush"{
                    let idxTuple = domainRepo.findModuleLessonIndices(str: studentRepo.recentActivities[studentRepo.recentActivities.count - 1])
                    (segueIdxModule, segueIdxLesson) = idxTuple
                }
                else if identifier == "improvement"{
                    segueIdxModule = findLowestScoreIndex()
                    segueIdxLesson = -1
                }
            }
            else {
                segueIdxModule = 0
                segueIdxLesson = -1
            }
            
            studentRepo.updateRecentActivities(modIdx: segueIdxModule, lesIdx: segueIdxLesson)
            
            if segueIdxLesson != -1 {
                performSegue(withIdentifier: "toLessonSegue", sender: nil)
            }
            else{
                performSegue(withIdentifier: "toModuleSegue", sender: nil)
            }
            
            return false
        }
        
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let child = segue.destination as? LessonListTVC {
            child.module = segueIdxModule
        }
        else if let child = segue.destination as? LessonWeb {
            child.lessonName = domainRepo.lessonNames[segueIdxModule][segueIdxLesson]
            child.modNum = segueIdxModule + 1
            child.lessonNum = segueIdxLesson + 1
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    
    
}
