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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.lessonNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lessonListCell", for: indexPath) as! LessonListCell
        
        cell.lblLessonTitle?.text = "\(repo.lessonNames[indexPath.row])"
        
        //TODO
        //cell.isCompleted = false
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
