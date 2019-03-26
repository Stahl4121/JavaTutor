//
//  LessonWeb.swift
//  JavaTutor
//
//  Created by Sam Diehl on 3/24/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit
import WebKit

class LessonWeb: UIViewController, WKUIDelegate {
    
    var lessonName: String = ""
    var modNum: Int = 0
    var lessonNum: Int = 0
    
    @IBOutlet weak var webV: WKWebView!
    @IBOutlet weak var webTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webTitle.title = lessonName
        
        //HTML Loading
        if let url = Bundle.main.url(forResource: "\(modNum).\(lessonNum)", withExtension: ".html") {
            webV.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
