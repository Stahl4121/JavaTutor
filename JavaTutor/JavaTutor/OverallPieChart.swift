//
//  OverallPieChart.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 4/20/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

struct Segment {
    
    // the color of a given segment
    var color: UIColor
    
    // the value of a given segment – will be used to automatically calculate a ratio
    var value: CGFloat
    
    
    
}

class OverallPieChart: UIView {
    
    var radius : CGFloat = 0.0
    
    /// An array of structs representing the segments of the pie chart
    var segments = [Segment]() {
        didSet {
            setNeedsDisplay() // re-draw view when the values get set
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false // when overriding drawRect, you must specify this to maintain transparency.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func draw(_ rect: CGRect) {
        
        // get current context
        let ctx = UIGraphicsGetCurrentContext()
        
        // radius is the half the frame's width or height (whichever is smallest)
        //let radius = min(frame.size.width, frame.size.height) * 0.5
        
        // center of the view
        let viewCenter = CGPoint(x: 500, y: 200 )//CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        
        // enumerate the total value of the segments by using reduce to sum them
        let valueCount = segments.reduce(0, {$0 + $1.value})
        
        // the starting angle is -90 degrees (top of the circle, as the context is flipped). By default, 0 is the right hand side of the circle, with the positive angle being in an anti-clockwise direction (same as a unit circle in maths).
        var startAngle = -CGFloat.pi * 0.5
        
        for segment in segments { // loop through the values array
            
            // set fill color to the segment color
            ctx?.setFillColor(segment.color.cgColor)
            
            // update the end angle of the segment
            let endAngle = startAngle + 2 * .pi * (segment.value / valueCount)
            
            // move to the center of the pie chart
            ctx?.move(to: viewCenter)
            
            // add arc from the center for each segment (anticlockwise is specified for the arc, but as the view flips the context, it will produce a clockwise arc)
            ctx?.addArc(center: viewCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            
            // fill segment
            ctx?.fillPath()
            
            //maybe do fillPath with pattern? idk
            
            // update starting angle of the next segment to the ending angle of this segment
            startAngle = endAngle
        }
    }
    
    public func getPoints(radiusPercentage: Double) -> [CGPoint] {
        var points = [CGPoint]()
        
        let chunkAngle = .pi * 2 / Double(segments.count)
        let center = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let scaledR = Double(radius) * radiusPercentage
        
        for i in 0..<segments.count {
            points.append(
                CGPoint(x: cos(chunkAngle * Double(i)) * scaledR + Double(center.x),
                        y: sin(chunkAngle * Double(i)) * scaledR + Double(center.y))
            )
        }
        
        return points
    }
}
