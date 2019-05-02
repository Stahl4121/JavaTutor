//
//  StatisticsVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 2/22/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class StatisticsVC: UIViewController {
    
    let studentRepo = StudentRepo.instance
    
    //View 1: what percentage of most recently visited module has student completed?
    @IBOutlet weak var lessonsReadView: UIButton!
    @IBOutlet weak var PercentRecentCompleted: UILabel!
    
    @IBOutlet weak var upArrowView: UIImageView!
    //View 2: what percentage of the tutorial have they completed?
    @IBOutlet weak var PercentTotalCompleted: UILabel!
    
    //View 3
    //@IBOutlet weak var QuizScores: UILabel!
    
    @IBOutlet weak var QuizAverage: UILabel!
    //View 4: how long have they spent in a lesson? (line graph)
  //  @IBOutlet weak var TimesInLesson: UILabel!
    
    //View 5: ring chart, how much of bloom's tax have they done?
    //TODO: perhaps have this record that extra activities thing?
    @IBOutlet weak var BloomsTaxonomy: UILabel!
    
    var percentLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoadSetup()  //you may call it from view did load also
        upArrowView.image = UIImage(named: "bookStack.jpg")
        lessonsReadView.addSubview(upArrowView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
        
    }
    
    func viewLoadSetup() {

        // Do any additional setup after loading the view.
        percentLabel = UILabel(frame: CGRect(origin: CGPoint(x: 735, y: 50), size: CGSize(width: 400, height: 400)))
        percentLabel.text = "%"
        percentLabel.font = UIFont.systemFont(ofSize: 90)
        percentLabel.textColor = UIColor.white
        
        //PercentRecentCompleted.text = "Progress through Module"
        PercentTotalCompleted.text = "Progress through Tutorial"
        //QuizScores.text = "Quiz Stuff"
        //TimesInLesson.text = "Time in Lesson"
        BloomsTaxonomy.text = "Bloom's Taxonomy"
        
        setQuizScores()
        
        //set up preview of user's overall progress
        let previewChart = OverallPieChart()
        previewChart.radius = min(view.frame.size.width, view.frame.size.height) * 0.25 * 0.50
        previewChart.frame = CGRect(x: 270, y: 60, width: view.frame.size.width, height: 400)
        
        let initialHue = 0.05
        for i in 0...9 {
            previewChart.segments.append(Segment(color: .init(hue: CGFloat(initialHue + (Double(i)/10)), saturation: 0.3, brightness: 0.8, alpha: 1), value: 10))
        }
        
        //set up preview of user's progress through module
        previewChart.isUserInteractionEnabled=false
        percentLabel.isUserInteractionEnabled=false

        //add subviews to main view
        view.addSubview(previewChart)
        view.addSubview(percentLabel)
        view.bringSubviewToFront(percentLabel)
        
        
        
    }
   
    
    func setQuizScores(){
    
        QuizAverage.text = "\(studentRepo.quizAvg.rounded())%"
        
        if studentRepo.quizAvg < 60 {
            QuizAverage.textColor = UIColor.red
        } else if studentRepo.quizAvg < 70 {
            QuizAverage.textColor = UIColor.orange
        } else if studentRepo.quizAvg < 90 {
            QuizAverage.textColor = UIColor.yellow
        } else if studentRepo.quizAvg <= 100 {
            QuizAverage.textColor = UIColor.green
        }
        
    }
    
    
    
}
