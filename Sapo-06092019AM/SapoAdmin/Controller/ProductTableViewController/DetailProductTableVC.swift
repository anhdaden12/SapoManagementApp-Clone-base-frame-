//
//  DetailProductTableVC.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/30/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class DetailProductTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Add rightBarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_option_edit_options"), style: .plain, target: self, action: #selector(didTapEditProperty))
        
        navigationController?.navigationBar.backIndicatorImage = nil
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = nil
        navigationItem.leftItemsSupplementBackButton = true
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = backButton
    }
    
    @objc func didTapEditProperty() {
        
        let addProductWithPropertyVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "addProductWithPropertyTableVC")
        show(addProductWithPropertyVC, sender: nil)
    }
    
    
}
