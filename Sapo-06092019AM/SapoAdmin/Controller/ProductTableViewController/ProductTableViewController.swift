//
//  ProductTableViewController.swift
//  SapoAdmin
//
//  Created by Minh Thang on 8/2/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController, ViewControllerDescription {
   
    static var instance : ProductTableViewController = {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ProductTableViewController") as! ProductTableViewController
    }()
    
    var orderInTabbar: Int = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}


class ProductNavigationController : UINavigationController {
    static var instance : ProductNavigationController = {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ProductNavigationController") as! ProductNavigationController
    }()
}
