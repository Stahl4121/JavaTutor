//
//  LessonListTVC.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/19/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class LessonListTVC: UITableViewController {
    let domainRepo = DomainRepo.instance
    let studentRepo = StudentRepo.instance
    
    var row: Int = 0
    var module: Int = 0
    
    @IBOutlet weak var lblLessonListTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLessonListTitle.text = "\(domainRepo.moduleNames[module]) Lesson List"
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        row = indexPath.row
        return indexPath
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.lessonNames[module].count + 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == repo.lessonNames[module].count + 1 {
            return tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath)
        }
            
        if indexPath.row == repo.lessonNames[module].count {
            return tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "lessonListCell", for: indexPath) as! LessonListCell
        cell.lblLessonTitle?.text = "\(repo.lessonNames[module][indexPath.row])"
        
        return cell
        //TODO
        //cell.isCompleted = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let child = segue.destination as? QuizTVC {
            child.module = self.module
        }
        
        if let child = segue.destination as? LessonWeb {
            //Update recent activities list
            if let index = studentRepo.recentActivities.firstIndex(of: domainRepo.lessonNames[module][row]){
                studentRepo.recentActivities.remove(at: index)
            }
            studentRepo.recentActivities.insert(domainRepo.lessonNames[module][row], at: 0)
            
            child.lessonName = domainRepo.lessonNames[module][row]
            child.modNum = self.module + 1
            child.lessonNum = self.row + 1
        }
        
    }
}
