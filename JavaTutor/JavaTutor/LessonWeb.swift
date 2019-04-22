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
    
    let repo = DataRepo.instance
    
    //TODO: Set a timer on this screen and when it hits 3 minutes, the user has finished the chapter
    var counter = 0
    var timer = Timer()
    
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
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)

        
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 
    
    @objc func update() {
        counter += 1
        if counter == 10 {
            repo.chaptersFinished[modNum-1] = repo.chaptersFinished[modNum-1] + 0.5
        } else if counter == 180 {
            repo.chaptersFinished[modNum-1] = repo.chaptersFinished[modNum-1] + 0.5
        }
    }

}
