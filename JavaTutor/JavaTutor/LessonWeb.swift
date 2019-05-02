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
    
    let studentRepo = StudentRepo.instance
    let domainRepo = DomainRepo.instance
   
    var counter = 0
    var timer = Timer()
    var lessonName: String = ""
    var modNum: Int = 0
    var lessonNum: Int = 0
    var finished : Double = 0
    var total : Double = 0
    
    @IBOutlet weak var webV: WKWebView!
    @IBOutlet weak var webTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webTitle.title = lessonName
        
        //HTML Loading
        if let url = Bundle.main.url(forResource: "\(modNum).\(lessonNum)", withExtension: ".html") {
            webV.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        
        //set up timer to measure how long user has spent on this webpage
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 
    //adjusts how many chapters student has read
    @objc func update() {
        counter += 1
        
        
        //Check if chapter has been read before
        if counter == 30 && !domainRepo.finishedLessons.contains(lessonName){
            
            finished = studentRepo.chaptersFinished[modNum-1]
            total = Double(domainRepo.lessonNames[modNum - 1].count)
            
            if finished < total {
                studentRepo.chaptersFinished[modNum-1] = studentRepo.chaptersFinished[modNum-1] + 1
                domainRepo.finishedLessons.append(lessonName)
            }
        }
    }

}
