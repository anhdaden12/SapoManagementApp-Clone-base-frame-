//
//  TabBarViewController.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/12/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var allViewController: [UIViewController] = [HomeNavigationController.instance,                                                                                                                     OrderNavigationController.instance,
                                                 ProductNavigationController.instance,
                                                 ReportNavigationController.instance,
                                                 MoreNavigationController.instance, //
        NotificationNavigationController.instance,
        PartnerNavigationController.instance
        ]
        { didSet {
            setViewControllers(Array(allViewController.dropLast(2)), animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(Array(allViewController.dropLast(2)), animated: true)
    }
}

