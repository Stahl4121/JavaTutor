//
//  ModuleCatalogTVC.swift
//  JavaTutor
//
//  Created by Emily Wasylenko on 2/22/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class ModuleListTVC: UITableViewController {
    let repo = DataRepo.instance
    
    var row: Int = 0
    
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
        return repo.moduleNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moduleCell", for: indexPath) as! ModuleCell
        
        cell.lblModuleTitle?.text = "Module \(indexPath.row + 1): \(repo.moduleNames[indexPath.row])"
        cell.lblPercComp?.text = "{#}%"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let child = segue.destination as? LessonListTVC {
            child.module = row
            
            //Update recent activities list
            if let index = repo.recentActivities.firstIndex(of: repo.moduleNames[row]){
                repo.recentActivities.remove(at: index)
            }
            repo.recentActivities.insert(repo.moduleNames[row], at: 0)
        }
    }

}
