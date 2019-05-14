//
//  ModuleProgDetailsVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 4/29/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class ModuleProgDetailsVC: UIViewController {

    
    let studentRepo = StudentRepo.instance
    let domainRepo = DomainRepo.instance
    
    @IBOutlet weak var mod1prog: UILabel!
    @IBOutlet weak var mod2prog: UILabel!
    @IBOutlet weak var mod3prog: UILabel!
    @IBOutlet weak var mod4prog: UILabel!
    @IBOutlet weak var mod5prog: UILabel!
    @IBOutlet weak var mod6prog: UILabel!
    
    var modProgressArray : [UILabel]!
    
    
    func viewLoadSetup() {
        
        for i in 0...(domainRepo.lessonNames.count - 1) {
            modProgressArray[i].text = "\((100 * studentRepo.chaptersFinished[i]/Double(domainRepo.lessonNames[i].count)).rounded())"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modProgressArray = [mod1prog, mod2prog, mod3prog, mod4prog, mod5prog, mod6prog]
        
        for i in 0...(domainRepo.lessonNames.count - 1)  {
            modProgressArray[i].text = "0.0"
        }
        
        viewLoadSetup()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    
}
