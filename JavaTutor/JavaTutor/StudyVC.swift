//
//  StudyVC.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/11/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class StudyVC: UIViewController {
    let repo = DomainRepo.instance
    
    @IBOutlet weak var lblContinueTopic: UILabel!
    @IBOutlet weak var lblImproveTopic: UILabel!
    
    @IBOutlet weak var lblBrushTopic: UILabel!
    @IBOutlet weak var lblWelcomeBack: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblContinueTopic.text = repo.continueTopic
        lblImproveTopic.text = repo.improveTopic
        lblBrushTopic.text = repo.brushUpTopic
        lblWelcomeBack.text = "Welcome back, \(repo.username)!"
        
        repo.addObserver(self, forKeyPath: "recentActivities", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !repo.recentActivities.isEmpty {
            lblContinueTopic.text = repo.recentActivities[0]
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
