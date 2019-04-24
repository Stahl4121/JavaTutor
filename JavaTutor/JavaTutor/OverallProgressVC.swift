//
//  OverallProgressVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 4/19/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class OverallProgressVC: UIViewController {
   
    let repo = DataRepo.instance
    
    let labelPoints : [CGPoint] = [
        /*red*/ CGPoint(x: 430, y: 195),
        /*orange*/ CGPoint(x: 530, y: 195),
        /*yellow*/ CGPoint(x: 610, y: 250),
        /*lime*/ CGPoint(x: 650, y: 350),
        /*green*/ CGPoint(x: 610, y: 440),
        /*aqua*/ CGPoint(x: 530, y: 500),
        /*blue*/ CGPoint(x: 430, y: 500),
        /*indigo*/ CGPoint(x: 350, y: 440),
        /*purple*/ CGPoint(x: 325, y: 350),
        /*pink*/ CGPoint(x: 350, y: 250)]
    
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
        
        //set up the total background chart to be filled
        let totalChart = OverallPieChart()
        totalChart.radius = min(view.frame.size.width, view.frame.size.height) * 0.25
        totalChart.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 400)
        
        let initialHue = 0.05
        for i in 0...9 {
            totalChart.segments.append(Segment(color: .init(hue: CGFloat(initialHue + (Double(i)/10)), saturation: 0.3, brightness: 0.8, alpha: 1/2), value: 10))
        }
        
        //set up 10 slices of user's progress so far
        for i in 0...9 {
            let newThing = OverallPieChart()
            newThing.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(repo.quizAvgPerMod[i]/100)
            newThing.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 400)
            for j in 0...9 {
                if j == ((i+9)%10){
                    newThing.segments.append(Segment(color: .init(hue: CGFloat(initialHue + (Double(j)/10)), saturation: 0.5, brightness: 0.9, alpha: 1), value: 10))
                } else {
                    newThing.segments.append(Segment(color: .clear, value: 10))
                }
            }
            slices.append(newThing)
        }

        view.addSubview(totalChart)
        
        for slice in slices {
            view.addSubview(slice)
        }
        
        for (i, s) in scoreLabels.enumerated() {
            view.addSubview(s)
            view.bringSubviewToFront(s)
            s.text = "\(Double(repo.quizAvgPerMod[i]).rounded())"
            s.font = UIFont.systemFont(ofSize: 22)
            s.textColor = UIColor.white
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
