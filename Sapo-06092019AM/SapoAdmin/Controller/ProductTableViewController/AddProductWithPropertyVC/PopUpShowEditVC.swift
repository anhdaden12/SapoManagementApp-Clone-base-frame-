//
//  PopUpShowEditVC.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/30/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class PopUpShowEditVC: UIViewController {
    
    var delegateShowEditView: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapEditProperty(_ sender: Any) {
        self.delegateShowEditView?()
    }
}
