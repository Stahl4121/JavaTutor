//
//  BloomsTaxonomyVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 5/5/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class BloomsTaxonomyVC: UIViewController {

    @IBOutlet weak var level1lbl: UILabel!
    @IBOutlet weak var level2lbl: UILabel!
    @IBOutlet weak var level3lbl: UILabel!
    
    let studentRepo = StudentRepo.instance
    
    func viewLoadSetup() {
        level1lbl.text = "\(studentRepo.bloomsTaxCorrect[0])"
        level2lbl.text = "\(studentRepo.bloomsTaxCorrect[1])"
        level3lbl.text = "\(studentRepo.bloomsTaxCorrect[2])"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoadSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
}
