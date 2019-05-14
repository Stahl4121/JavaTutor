    //
    //  RecentActivityTVC.swift
    //  JavaTutor
    //
    //  Created by Emily Wasylenko on 2/22/19.
    //  Copyright © 2019 Logan Stahl. All rights reserved.
    //
    
    import UIKit
    
    class RecentActivityTVC: UITableViewController {
        let studentRepo = StudentRepo.instance
        let domainRepo = DomainRepo.instance
        
        
        var row: Int = 0
        var segueIdxModule : Int = 0
        var segueIdxLesson : Int = -1
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            studentRepo.addObserver(self, forKeyPath: "recentActivities", options: .new, context: nil)
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            tableView.reloadData()
        }
        
        override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
            row = indexPath.row
            return indexPath
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return studentRepo.recentActivities.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "moduleCell", for: indexPath) as! ModuleCell
            
            cell.lblModuleTitle?.text = "\(studentRepo.recentActivities[indexPath.row])"
            cell.lblPercComp?.text = "{#}%"
            
            return cell
        }
        
        override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
            
            (segueIdxModule, segueIdxLesson) = domainRepo.findModuleLessonIndices(str: studentRepo.recentActivities[row])
            
            studentRepo.updateRecentActivities(modIdx: segueIdxModule, lesIdx: segueIdxLesson)
            
            if segueIdxLesson != -1 {
                performSegue(withIdentifier: "toRALessonSegue", sender: nil)
            }
            else{
                //Then it will by default go to the module screen
                return true
            }
            
            return false
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let child = segue.destination as? LessonListTVC {
                child.module = segueIdxModule
            }
            else if let child = segue.destination as? LessonWeb {
                child.lessonName = domainRepo.lessonNames[segueIdxModule][segueIdxLesson]
                child.modNum = segueIdxModule + 1
                child.lessonNum = segueIdxLesson + 1
            }
        }
    }
