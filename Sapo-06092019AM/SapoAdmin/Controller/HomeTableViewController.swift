//
//  HomeTableViewController.swift
//  SapoAdmin
//
//  Created by Minh Thang on 8/2/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, ViewControllerDescription {
    
    static var instance : HomeTableViewController = {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "HomeTableViewController") as! HomeTableViewController
    }()
    
    var orderInTabbar: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
   }
  
}

class HomeNavigationController : UINavigationController {
    static var instance : HomeNavigationController = {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as! HomeNavigationController
    }()
}
