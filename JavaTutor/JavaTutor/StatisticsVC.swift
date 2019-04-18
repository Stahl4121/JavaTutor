//
//  StatisticsVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 2/22/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class StatisticsVC: UIViewController {

    let repo = DataRepo.instance
    
    //View 1: what percentage of most recently visited module has student completed?
    @IBOutlet weak var PercentRecentCompleted: UILabel!
    
    //View 2: what percentage of the tutorial have they completed?
    @IBOutlet weak var PercentTotalCompleted: UILabel!
    
    //View 3
    @IBOutlet weak var QuizScores: UILabel!
    
    @IBOutlet weak var QuizAverage: UILabel!
    //View 4: how long have they spent in a lesson? (line graph)
    @IBOutlet weak var TimesInLesson: UILabel!
    
    //View 5: ring chart, how much of bloom's tax have they done?
    //TODO: perhaps have this record that extra activities thing?
    @IBOutlet weak var BloomsTaxonomy: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoadSetup()  //you may call it from view did load also
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
        
    }
    
    func viewLoadSetup() {

        // Do any additional setup after loading the view.
        PercentRecentCompleted.text = "Progress through Module"
        PercentTotalCompleted.text = "Progress through Tutorial"
        QuizScores.text = "Quiz Stuff"
        //TimesInLesson.text = "Time in Lesson"
        BloomsTaxonomy.text = "Bloom's Taxonomy"
        
        setQuizScores()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func setQuizScores(){
    
        QuizAverage.text = "\(Int(repo.quizAvg))%"
        
        if repo.quizAvg < 60 {
            QuizAverage.textColor = UIColor.red
        } else if repo.quizAvg < 70 {
            QuizAverage.textColor = UIColor.orange
        } else if repo.quizAvg < 90 {
            QuizAverage.textColor = UIColor.yellow
        } else if repo.quizAvg <= 100 {
            QuizAverage.textColor = UIColor.green
        }
        
        
    }
    
    
    
}
