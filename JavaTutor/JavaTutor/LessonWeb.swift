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
    var modRow: Int = 0
    
    @IBOutlet weak var webV: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(modNum)")
        print("\(modRow)")
        print("\(modName)")
        
        /*
        //test URL
        let myURL = URL(string: "https://www.youtube.com")
        let myReq = URLRequest(url: myURL!)
        webV.load(myReq)
        */
        
        //testing HTML Loading
        if let url = Bundle.main.url(forResource: "sec1.1", withExtension: ".html", subdirectory: "Sprint 1 HTML") {
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
