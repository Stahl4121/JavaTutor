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
    
    @IBOutlet weak var lblContinueTopic: UILabel!
    @IBOutlet weak var lblImproveTopic: UILabel!
    
    @IBOutlet weak var lblBrushTopic: UILabel!
    @IBOutlet weak var lblWelcomeBack: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblContinueTopic.text = studentRepo.continueTopic
        lblImproveTopic.text = studentRepo.improveTopic
        lblBrushTopic.text = studentRepo.brushUpTopic
        lblWelcomeBack.text = "Welcome back, \(studentRepo.username)!"
        
        studentRepo.addObserver(self, forKeyPath: "recentActivities", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !studentRepo.recentActivities.isEmpty {
            lblContinueTopic.text = studentRepo.recentActivities[0]
        }
    }

}
