//
//  WarehouseViewController.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/23/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class WarehouseViewController: UITableViewController {
    
    static var instance: WarehouseViewController = {
        return UIStoryboard(name: "Report", bundle: nil).instantiateViewController(withIdentifier: "warehouseVC") as! WarehouseViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
         tableView.tableFooterView?.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }
    
    
    
}
