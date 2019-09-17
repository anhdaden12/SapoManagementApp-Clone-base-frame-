//
//  PartnerViewController.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/12/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class PartnerViewController: UITableViewController, ViewControllerDescription {
    
    var orderInTabbar: Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

class PartnerNavigationController: UINavigationController {
    
    static var instance : PartnerNavigationController = {
        let storyboard = UIStoryboard(name: "Partner", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "PartnerNavigationController") as! PartnerNavigationController
    }()
    
}
