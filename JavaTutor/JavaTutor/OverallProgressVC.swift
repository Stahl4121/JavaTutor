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
    
    @IBOutlet weak var score1lbl: UILabel!
    @IBOutlet weak var score2lbl: UILabel!
    @IBOutlet weak var score3lbl: UILabel!
    @IBOutlet weak var score4lbl: UILabel!
    @IBOutlet weak var score5lbl: UILabel!
    @IBOutlet weak var score6lbl: UILabel!
    @IBOutlet weak var score7lbl: UILabel!
    @IBOutlet weak var score8lbl: UILabel!
    @IBOutlet weak var score9lbl: UILabel!
    @IBOutlet weak var score10lbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoadSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
        
    }
    
    
    func viewLoadSetup() {

        //%finished corresponds to radius
        //largest percentage = width * 0.25
        
        //set up the total background to be filled
        let totalChart = OverallPieChart()
        totalChart.radius = min(view.frame.size.width, view.frame.size.height) * 0.25
        totalChart.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        totalChart.segments = [
            Segment(color: .init(hue: 0.65, saturation: 0.3, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.75, saturation: 0.3, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.85, saturation: 0.3, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.95, saturation: 0.3, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.05, saturation: 0.3, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.15, saturation: 0.3, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.25, saturation: 0.3, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.35, saturation: 0.3, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.45, saturation: 0.3, brightness: 0.8, alpha: 1/2), value: 10),
            Segment(color: .init(hue: 0.55, saturation: 0.3, brightness: 0.8, alpha: 1/2), value: 10)
        ]
        
        //display the progress that users have made so far on each module
        //width = v.f.s.w/2 * (#chapters finished in mod)/(total chapters in mod) * (mod quiz score)/100
        //height = 200 * (#chapters finished in mod)/(total chapters in mod) * (mod quiz score)/100
        let mod1Progress = OverallPieChart()
        mod1Progress.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(repo.quizAvgPerMod[0]/100)
        mod1Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
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
            Segment(color: .init(hue: 0.55, saturation: 0.5, brightness: 0.9, alpha: 1), value: 10)
        ]
        
        let mod2Progress = OverallPieChart()
        mod2Progress.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(repo.quizAvgPerMod[1]/100)
        mod2Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        mod2Progress.segments = [
            Segment(color: .init(hue: 0.65, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10)
        ]
        
        let mod3Progress = OverallPieChart()
        mod3Progress.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(repo.quizAvgPerMod[2]/100)
        mod3Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        mod3Progress.segments = [
            Segment(color: .clear, value: 10),
            Segment(color: .init(hue: 0.75, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10)
        ]
        
        let mod4Progress = OverallPieChart()
        mod4Progress.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(repo.quizAvgPerMod[3]/100)
        mod4Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        mod4Progress.segments = [
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .init(hue: 0.85, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10)
        ]
        
        let mod5Progress = OverallPieChart()
        mod5Progress.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(repo.quizAvgPerMod[4]/100)
        mod5Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        mod5Progress.segments = [
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .init(hue: 0.95, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10)
        ]
        
        let mod6Progress = OverallPieChart()
        mod6Progress.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(repo.quizAvgPerMod[5]/100)
        mod6Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        mod6Progress.segments = [
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .init(hue: 0.05, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10)
        ]
        
        
        let mod7Progress = OverallPieChart()
        mod7Progress.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(repo.quizAvgPerMod[6]/100)
        mod7Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        mod7Progress.segments = [
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .init(hue: 0.15, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10)
        ]
        
        let mod8Progress = OverallPieChart()
        mod8Progress.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(repo.quizAvgPerMod[7]/100)
        mod8Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        mod8Progress.segments = [
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .init(hue: 0.35, saturation: 0.5, brightness: 0.8, alpha: 1), value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10)
        ]
        
        let mod9Progress = OverallPieChart()
        mod9Progress.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(repo.quizAvgPerMod[8]/100)
        mod9Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        mod9Progress.segments = [
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .init(hue: 0.05, saturation: 0.8, brightness: 1.0, alpha: 1), value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10)
        ]
        
        let mod10Progress = OverallPieChart()
        mod10Progress.radius = CGFloat(min(view.frame.size.width, view.frame.size.height)) * CGFloat(0.25) * CGFloat(repo.quizAvgPerMod[9]/100)
        mod10Progress.frame = CGRect(
            x: 0,
            y: 200,
            width: view.frame.size.width,
            height: 400)
        mod10Progress.segments = [
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .clear, value: 10),
            Segment(color: .init(hue: 0.45, saturation: 0.5, brightness: 1.0, alpha: 1), value: 10),
            Segment(color: .clear, value: 10)
        ]
        
        //add all views to the subview
        view.addSubview(totalChart)
        view.addSubview(mod1Progress)
        view.addSubview(mod2Progress)
        view.addSubview(mod3Progress)
        view.addSubview(mod4Progress)
        view.addSubview(mod5Progress)
        view.addSubview(mod6Progress)
        view.addSubview(mod7Progress)
        view.addSubview(mod8Progress)
        view.addSubview(mod9Progress)
        view.addSubview(mod10Progress)
        
        
        score1lbl.text = "\(Double(repo.quizAvgPerMod[0]).rounded())"
        score2lbl.text = "\(Double(repo.quizAvgPerMod[1]).rounded())"
        score3lbl.text = "\(Double(repo.quizAvgPerMod[2]).rounded())"
        score4lbl.text = "\(Double(repo.quizAvgPerMod[3]).rounded())"
        score5lbl.text = "\(Double(repo.quizAvgPerMod[4]).rounded())"
        score6lbl.text = "\(Double(repo.quizAvgPerMod[5]).rounded())"
        score7lbl.text = "\(Double(repo.quizAvgPerMod[6]).rounded())"
        score8lbl.text = "\(Double(repo.quizAvgPerMod[7]).rounded())"
        score9lbl.text = "\(Double(repo.quizAvgPerMod[8]).rounded())"
        score10lbl.text = "\(Double(repo.quizAvgPerMod[9]).rounded())"
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
        
}
