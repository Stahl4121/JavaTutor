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
        totalChart.radius = min(view.frame.size.width, view.frame.size.height) * 0.5
        totalChart.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        totalChart.segments = [
            Segment(color: .init(hue: 0.65, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.75, saturation: 0.5, brightness: 0.6, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.85, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.95, saturation: 0.5, brightness: 0.6, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.05, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.15, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.25, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.35, saturation: 0.5, brightness: 0.6, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.45, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.55, saturation: 0.5, brightness: 0.8, alpha: 1/2), value: 10)
        ]
        
        //display the progress that users have made so far on each module
        //width = v.f.s.w/2 * (#chapters finished in mod)/(total chapters in mod) * (mod quiz score)/100
        //height = 200 * (#chapters finished in mod)/(total chapters in mod) * (mod quiz score)/100
        let mod1Progress = OverallPieChart()
        mod1Progress.radius = min(view.frame.size.width, view.frame.size.height) * 0.5
        mod1Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 200)
        mod1Progress.segments = [
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .init(hue: 0.55, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10)
        ]
        
        
        let mod2Progress = OverallPieChart()
        mod2Progress.radius = min(view.frame.size.width, view.frame.size.height) * 0.05
        mod2Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        mod2Progress.segments = [
            Segment(color: .init(hue: 0.55, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .init(hue: 0.65, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .init(hue: 0.55, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .init(hue: 0.65, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .init(hue: 0.55, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .init(hue: 0.65, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .init(hue: 0.55, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .init(hue: 0.65, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .init(hue: 0.55, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .init(hue: 0.35, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .init(hue: 0.75, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10)
        ]
        
        
        //add all views to the subview
        view.addSubview(totalChart)
        view.addSubview(mod1Progress)
        view.addSubview(mod2Progress)
        /*view.addSubview(mod3Progress)
        view.addSubview(mod4Progress)
        view.addSubview(mod5Progress)
        view.addSubview(mod6Progress)
        view.addSubview(mod7Progress)
        view.addSubview(mod8Progress)
        view.addSubview(mod9Progress)
        view.addSubview(mod10Progress)*/
        
        
       
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
        
}
