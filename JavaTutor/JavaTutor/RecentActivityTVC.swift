//
//  RecentActivityTVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 2/22/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class RecentActivityTVC: UITableViewController {
    let repo = DataRepo.instance
    
    var row: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repo.addObserver(self, forKeyPath: "recentActivities", options: .new, context: nil)
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
        return repo.recentActivities.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moduleCell", for: indexPath) as! ModuleCell
        
        cell.lblModuleTitle?.text = "\(repo.recentActivities[indexPath.row])"
        cell.lblPercComp?.text = "{#}%"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let child = segue.destination as? LessonListTVC {
            child.module = row
        }
    }
}
