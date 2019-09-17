//
//  OrderTableViewController.swift
//  SapoAdmin
//
//  Created by Minh Thang on 8/2/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    static var instance : OrderTableViewController = {
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "OrderTableViewController") as! OrderTableViewController
    }()
    
    var orderInTabbar: Int = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
}


class OrderNavigationController : UINavigationController {
    static var instance : OrderNavigationController = {
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "OrderNavigationController") as! OrderNavigationController
    }()
}
