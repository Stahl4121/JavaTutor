//
//  LessonProgressView.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 5/2/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class LessonProgressView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        
        aPath.move(to: CGPoint(x:100, y:200))
        
        aPath.addLine(to: CGPoint(x:200, y:100))
        aPath.addLine(to: CGPoint(x:300, y:100))
        aPath.addLine(to: CGPoint(x:300, y:200))
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        
        //If you want to stroke it with a red color
        UIColor.green.set()
        aPath.lineWidth = 20
        aPath.stroke()
        //If you want to fill it as well
        //aPath.fill()
    }

}
