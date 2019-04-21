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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the total background to be filled
        let totalChart = OverallPieChart()
        totalChart.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 400)
        totalChart.segments = [
            Segment(color: .init(hue: 0.65, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 20),
            Segment(color: .init(hue: 0.75, saturation: 0.5, brightness: 0.6, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.85, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 15),
            Segment(color: .init(hue: 0.95, saturation: 0.5, brightness: 0.6, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.05, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 5),
            Segment(color: .init(hue: 0.15, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 5),
            Segment(color: .init(hue: 0.25, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.35, saturation: 0.5, brightness: 0.6, alpha: 1/2), value: 5),
            Segment(color: .init(hue: 0.45, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.55, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 10)
        ]
        
        //display the progress that users have made so far on each module
        //width = v.f.s.w/2 * (#chapters finished in mod)/(total chapters in mod) * (mod quiz score)/100
        //height = 200 * (#chapters finished in mod)/(total chapters in mod) * (mod quiz score)/100
        let mod1Progress = OverallPieChart()
        mod1Progress.frame = CGRect(x: 256, y: 300, width: view.frame.size.width/2, height: 400/2)
        mod1Progress.segments = [
            Segment(color: .clear, value: 20),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 15),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 5),
            Segment(color: .clear, value: 5),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 5),
            Segment(color: .clear, value: 10),
            Segment(color: .init(hue: 0.55, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10)
        ]
        
       // REMEMBER to update which slices are clear!!
        
        view.addSubview(totalChart)
        view.addSubview(mod1Progress)
        
       
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
        
}
