//
//  ModuleCatalogVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 3/11/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblModuleCat: UILabel!
    
    @IBOutlet weak var lblHorizLine: UILabel!
    
    @IBOutlet weak var lblSubHeader: UILabel!
    
    @IBOutlet weak var lblMod1: UILabel!
    
    @IBOutlet weak var lblMod2: UILabel!
    
    @IBOutlet weak var lblMod3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background
        view.backgroundColor = UIColor.init(displayP3Red: (215/255), green: (245/255), blue: (255/255), alpha: (255/255))
        
        
        //draw header rectangle
        let k = Draw(frame: CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: 850, height: 250)))
        
        self.view.addSubview(k)
        
        k.draw(CGRect(
            origin: CGPoint(x: 50, y: 50),
            size: CGSize(width: 100, height: 100)))
        
        k.backgroundColor = UIColor.init(displayP3Red: (125/255), green: (155/255), blue: (165/255), alpha: (255/255))
        
        
        //edit labels
        lblMod1.layer.masksToBounds = true
        lblMod1.layer.cornerRadius = 20
        lblMod1.textColor = UIColor.init(displayP3Red: (25/255), green: (55/255), blue: (65/255), alpha: (255/255))
        
        lblMod2.layer.masksToBounds = true
        lblMod2.layer.cornerRadius = 20
        lblMod2.textColor = UIColor.init(displayP3Red: (25/255), green: (55/255), blue: (65/255), alpha: (255/255))
        
        lblMod3.layer.masksToBounds = true
        lblMod3.layer.cornerRadius = 20
        lblMod3.textColor = UIColor.init(displayP3Red: (25/255), green: (55/255), blue: (65/255), alpha: (255/255))
        
        
        lblMod1.layer.shadowColor = UIColor.black.cgColor
        lblMod1.layer.shadowOpacity = 0.8
        lblMod1.layer.shadowOffset = CGSize(width: 100, height: 100)
        //lblMod1.dropS
        
        //.init(displayP3Red: (125/255), green: (155/255), blue: (165/255), alpha: (255/255))
        lblMod2.shadowColor = UIColor.init(displayP3Red: (125/255), green: (155/255), blue: (165/255), alpha: (255/255))
        lblMod3.shadowColor = UIColor.init(displayP3Red: (125/255), green: (155/255), blue: (165/255), alpha: (255/255))
        
        
        //set labels
        view.addSubview(lblModuleCat)
        view.addSubview(lblHorizLine)
        view.addSubview(lblSubHeader)
        view.addSubview(lblMod1)
        view.addSubview(lblMod2)
        view.addSubview(lblMod3)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



class Draw: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*  override func draw(_ rect: CGRect) {
     let h = rect.height
     let w = rect.width
     // var color:UIColor = UIColor.red
     
     //  var drect = CGRect(x: (w * 0.25),y: (h * 0.25),width: (w * 0.5),height: (h * 0.5))
     //  var bpath:UIBezierPath = UIBezierPath(rect: drect)
     
     // color.set()
     // bpath.stroke()
     
     print("it ran")
     
     NSLog("drawRect has updated the view")
     
     }
     */
}

