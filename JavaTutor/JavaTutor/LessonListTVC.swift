//
//  LessonListTVC.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/19/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class LessonListTVC: UITableViewController {
    let repo = DataRepo.instance
    
    var row: Int = 0
    var module: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return repo.lessonNames[module].count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == repo.lessonNames[module].count{
            return tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath)
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "lessonListCell", for: indexPath) as! LessonListCell
        
            cell.lblLessonTitle?.text = "\(repo.lessonNames[module][indexPath.row])"
        
            return cell
            //TODO
            //cell.isCompleted = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let child = segue.destination as? QuestionTVC {
            child.module = self.module
            child.selectedQuestion = 0
        }
        else{
            //Update recent activities list 
            if let index = repo.recentActivities.firstIndex(of: repo.lessonNames[module][row]){
                repo.recentActivities.remove(at: index)
            }
            repo.recentActivities.insert(repo.lessonNames[module][row], at: 0)
        }
    }
    
}
