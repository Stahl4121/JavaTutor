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
    //@IBOutlet weak var lessonsReadView: UIButton!
    
    @IBOutlet weak var lessonView: UIView!
    @IBOutlet weak var PercentRecentCompleted: UILabel!
    @IBOutlet weak var PercentTotalCompleted: UILabel!
    @IBOutlet weak var QuizAverage: UILabel!
    @IBOutlet weak var BloomsTaxonomy: UILabel!
    @IBOutlet weak var bloomTaxPyramid: UIImageView!
    @IBOutlet weak var upArrowView: UIImageView!
    
    
    var percentLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoadSetup()  //you may call it from view did load also
        upArrowView.image = UIImage(named: "bookStack.jpg")
        bloomTaxPyramid.image = UIImage(named: "pyramid.png")
        
        bloomTaxPyramid.alpha = 0.60
        lessonView.addSubview(upArrowView)
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
        
        PercentTotalCompleted.text = "Progress through Tutorial"
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
