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
    
    var modName: String = ""
    var modNum: Int = 0
    var modLesson: Int = 0
    
    @IBOutlet weak var webV: WKWebView!
    @IBOutlet weak var webTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(modNum)")
        print("\(modLesson)")
        print("\(modName)")
        
        webTitle.title = modName
        
        //testing HTML Loading
        if let url = Bundle.main.url(forResource: "\(modNum).\(modLesson)", withExtension: ".html", subdirectory: "Sprint 1 HTML") {
            webV.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        
        //Add Lesson name as page title
        
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
