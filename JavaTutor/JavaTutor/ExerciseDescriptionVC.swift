//
//  ExerciseDescriptionVC.swift
//  JavaTutor
//
//  Created by Sam Carlin on 5/7/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class ExerciseDescriptionVC: UIViewController {

    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var expectedOutputText: UITextView!
    
    @IBAction func reloadCodeClicked(_ sender: Any) {
        let alert = UIAlertController(
            title: "Reload Starter Code",
            message: "Reloading the starter code will erase all progress! Are you sure about this?",
            preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(
            title: "Yes, Delete My Code",
            style: UIAlertAction.Style.destructive,
            handler: { (_) in self.exerciseVC!.loadCode() }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    var exerciseVC : ExerciseVC?
    var exercise : Exercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionText.text = exercise!.description
        expectedOutputText.text = exercise!.output
    }
}
