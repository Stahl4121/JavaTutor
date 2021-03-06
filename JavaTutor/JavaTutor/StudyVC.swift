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
    
    var feedback = ""
    
    @IBOutlet weak var lblContinueTopic: UILabel!
    @IBOutlet weak var lblImproveTopic: UILabel!
    @IBOutlet weak var lblBrushTopic: UILabel!
    @IBOutlet weak var lblWelcomeBack: UILabel!
    
    @IBOutlet weak var lblFeedPop: UILabel!
    @IBOutlet weak var feedButton: UIBarButtonItem!
    @IBAction func clickFeedback(_ sender: Any) {
        showFeedback()
    }
    
    func showFeedback() {
        // Create alert controller
        let alertController = UIAlertController(title: "Help Us Improve", message: "Give us your feedback or report a bug", preferredStyle: .alert)
        // Create 'Enter' action
        let actionConfirm = UIAlertAction(title: "Enter", style: .default) { (_) in
            // Create text fields for alerts
            let name = alertController.textFields?[0].text
            let feed = alertController.textFields?[1].text
            // Grab data from user input, saved to feedback for storage
            self.feedback = "Name: " + name! + "Feedback: " + feed!
            // Write 'feedback' to Feedback.rtf and save it locally
            do {
                let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let destURL = URL(fileURLWithPath: destPath)
                let finalDestURL = destURL.appendingPathComponent("Feedback.rtf")
                try self.feedback.write(to: finalDestURL, atomically: true, encoding: .utf8)
                //Print Doc Directory
                //print("Doc Directory: \(finalDestURL)")
            }
            // Catch if something in feedback breaks
            catch {
                print("Error")
            }
        }
        // Create 'Cancel' action
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        // Add Name text field
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        // Add Feedback text field
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Feedback"
        }
        // Add actions to alert controller
        alertController.addAction(actionConfirm)
        alertController.addAction(actionCancel)
        // Show alert on call
        self.present(alertController, animated: true, completion: nil)
    }
    
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
