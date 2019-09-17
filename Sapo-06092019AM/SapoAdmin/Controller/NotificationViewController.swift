//
//  NotificeViewController.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/12/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class NotificationViewController: UITableViewController, ViewControllerDescription {
    
    static var instance : NotificationViewController = {
        let storyboard = UIStoryboard(name: "Notification", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
    }()
    
    var orderInTabbar: Int = 6

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


class NotificationNavigationController: UINavigationController {

    static var instance : NotificationNavigationController = {
        let storyboard = UIStoryboard(name: "Notification", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "NotificationNavigationController") as! NotificationNavigationController
    }()
    
}
