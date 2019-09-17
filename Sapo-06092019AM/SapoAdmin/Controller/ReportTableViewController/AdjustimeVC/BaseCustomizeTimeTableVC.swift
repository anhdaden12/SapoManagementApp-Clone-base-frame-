//
//  BaseCustomizeTimeTableVC.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit


class BaseCustomeTimeTableVC: UITableViewController {
    
    var userDefaultKey: String {
        return ""
    }
    var listTime : [Time] {
        return []
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedIndexpath = UserDefaults.standard.load(withKey: userDefaultKey, type: IndexPath.self) {
            tableView.selectRow(at: selectedIndexpath, animated: false, scrollPosition: .none)
            let cell = tableView.cellForRow(at: selectedIndexpath)
            cell?.accessoryType = .checkmark
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTime.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TimeCell
        cell.textLabel?.text = listTime[indexPath.row].title
        cell.detailTextLabel?.text = listTime[indexPath.row].detail
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        _ = UserDefaults.standard.save(withKey: userDefaultKey, value: indexPath)
    }
    
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
