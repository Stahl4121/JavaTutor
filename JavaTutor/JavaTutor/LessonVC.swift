//
//  LessonVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 3/11/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class LessonVC: UIViewController {

    
    
    @IBOutlet weak var lblLessonList: UILabel!
    
    @IBOutlet weak var lblHorizLine: UILabel!
    
    @IBOutlet weak var lblChooseLesson: UILabel!
    
    
    @IBOutlet weak var lblHelloWorld: UILabel!
    
    @IBOutlet weak var lblThis: UILabel!
    
    @IBOutlet weak var lblOtherThing: UILabel!
    
    @IBOutlet weak var tempBackBtn: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background
        view.backgroundColor = UIColor.init(displayP3Red: (215/255), green: (245/255), blue: (255/255), alpha: (255/255))
        
        
        //draw header rectangle
        let k = Draw(frame: CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: 1040, height: 250)))
        
        self.view.addSubview(k)
        
        k.draw(CGRect(
            origin: CGPoint(x: 50, y: 50),
            size: CGSize(width: 100, height: 100)))
        
        k.backgroundColor = UIColor.init(displayP3Red: (125/255), green: (155/255), blue: (165/255), alpha: (255/255))
        
        
        //edit labels
        lblHelloWorld.layer.masksToBounds = true
        lblHelloWorld.layer.cornerRadius = 20
        lblHelloWorld.textColor = UIColor.init(displayP3Red: (25/255), green: (55/255), blue: (65/255), alpha: (255/255))
        
        lblThis.layer.masksToBounds = true
        lblThis.layer.cornerRadius = 20
        lblThis.textColor = UIColor.init(displayP3Red: (25/255), green: (55/255), blue: (65/255), alpha: (255/255))
        
        lblOtherThing.layer.masksToBounds = true
        lblOtherThing.layer.cornerRadius = 20
        lblOtherThing.textColor = UIColor.init(displayP3Red: (25/255), green: (55/255), blue: (65/255), alpha: (255/255))
        
        
        lblHelloWorld.layer.shadowColor = UIColor.black.cgColor
        lblHelloWorld.layer.shadowOpacity = 0.8
        lblHelloWorld.layer.shadowOffset = CGSize(width: 100, height: 100)
        //lblHelloWorld.dropS
        
        //.init(displayP3Red: (125/255), green: (155/255), blue: (165/255), alpha: (255/255))
        lblThis.shadowColor = UIColor.init(displayP3Red: (125/255), green: (155/255), blue: (165/255), alpha: (255/255))
        lblOtherThing.shadowColor = UIColor.init(displayP3Red: (125/255), green: (155/255), blue: (165/255), alpha: (255/255))
        
        
        //set labels
        view.addSubview(lblLessonList)
        view.addSubview(lblHorizLine)
        view.addSubview(lblChooseLesson)
        view.addSubview(lblHelloWorld)
        view.addSubview(lblThis)
        view.addSubview(lblOtherThing)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


