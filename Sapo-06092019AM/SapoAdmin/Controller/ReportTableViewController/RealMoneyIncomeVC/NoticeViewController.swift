//
//  NoticeViewController.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 9/3/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backImage = UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popnav))
        
    }
    
    @objc func popnav() {
        self.navigationController?.popViewController(animated: true)
    }

}
