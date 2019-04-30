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
    
    @IBOutlet weak var mod1prog: UILabel!
    @IBOutlet weak var mod2prog: UILabel!
    @IBOutlet weak var mod3prog: UILabel!
    @IBOutlet weak var mod4prog: UILabel!
    @IBOutlet weak var mod5prog: UILabel!
    @IBOutlet weak var mod6prog: UILabel!
    @IBOutlet weak var mod7prog: UILabel!
    @IBOutlet weak var mod8prog: UILabel!
    @IBOutlet weak var mod9prog: UILabel!
    @IBOutlet weak var mod10prog: UILabel!
    
    
    
    
    func viewLoadSetup() {
        mod1prog.text = "\(studentRepo.chaptersFinished[0] + 8)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoadSetup()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    
}
