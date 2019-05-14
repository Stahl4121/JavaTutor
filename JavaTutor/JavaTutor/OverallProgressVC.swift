//
//  OverallProgressVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 4/19/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class OverallProgressVC: UIViewController {
   
    let studentRepo = StudentRepo.instance
    
    let labelPoints : [CGPoint] = [
        /*red*/ CGPoint(x: 400, y: 200),
        /*orange*/ CGPoint(x: 560, y: 200),
        /*yellow*/ CGPoint(x: 640, y: 350),
        /*green*/ CGPoint(x: 560, y: 475),
        /*blue*/ CGPoint(x: 400, y: 475),
        /*purple*/ CGPoint(x: 320, y: 350)
    ]
    
    var slices : [OverallPieChart] = []
    
    var scoreLabels : [UILabel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //list of user's scores
        for p in labelPoints {
            scoreLabels.append(UILabel(frame: CGRect(origin: p, size: CGSize(width: 100, height: 100))))
        }
        
        viewLoadSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    
    
    func viewLoadSetup() {
        let segCount = studentRepo.quizAvgPerMod.count
        
        //set up the total background chart to be filled
        let totalChart = OverallPieChart()
        totalChart.radius = min(view.frame.size.width, view.frame.size.height) * 0.25
        totalChart.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 400)
        
        let initialHue = 0.05
        for i in 0..<segCount {
            totalChart.segments.append(Segment(color: .init(hue: CGFloat(initialHue + (Double(i)/Double(segCount))), saturation: 0.3, brightness: 0.8, alpha: 1/2), value: CGFloat(segCount)))
        }
        
        //set up slices of user's progress so far
        for i in 0..<segCount {
            let newThing = OverallPieChart()
            newThing.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(studentRepo.quizAvgPerMod[i]/100)
            newThing.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 400)
            for j in 0..<segCount {
                if j == ((i + segCount - 1) % segCount){
                    newThing.segments.append(Segment(color: .init(hue: CGFloat(initialHue + (Double(j)/Double(segCount))), saturation: 0.5, brightness: 0.9, alpha: 1), value: CGFloat(segCount)))
                } else {
                    newThing.segments.append(Segment(color: .clear, value: CGFloat(segCount)))
                }
            }
            slices.append(newThing)
        }

        view.addSubview(totalChart)
        
        for slice in slices {
            view.addSubview(slice)
        }
        
        //add user's score numbers to view
        for (i, s) in scoreLabels.enumerated() {
            view.addSubview(s)
            view.bringSubviewToFront(s)
            s.text = "\(Double(studentRepo.quizAvgPerMod[i]).rounded())"
            s.font = UIFont.systemFont(ofSize: 22)
            s.textColor = UIColor.white
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
