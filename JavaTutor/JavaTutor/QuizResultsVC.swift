//
//  QuizResultsVC.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/23/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class QuizResultsVC: UIViewController {
    
    var numCorrect: Int = 0
    var numIncorrect: Int = 0
    
    @IBOutlet weak var lblNumCorrect: UILabel!
    @IBOutlet weak var lblNumIncorrect: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    
    override func viewDidLoad() {
        
        //Remove questions from the nav controller, so user cannot re-enter quiz
        var navigationArray = self.navigationController?.viewControllers //To get all UIViewController stack as Array
        for _ in 1...(numCorrect+numIncorrect){
            navigationArray!.remove(at: (navigationArray?.count)! - 2) // To remove previous UIViewController
        }
        self.navigationController?.viewControllers = navigationArray!
        
        
        lblNumCorrect.text = String(numCorrect)
        lblNumIncorrect.text = String(numIncorrect)
        lblScore.text = "\(Int(((Double(numCorrect)/Double(numCorrect+numIncorrect))*100).rounded()))%"
        
        
        super.viewDidLoad()
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
