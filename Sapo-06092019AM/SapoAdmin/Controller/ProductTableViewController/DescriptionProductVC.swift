//
//  DescriptionProductVC.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class DescriptionProductVC: UIViewController {
    
    @IBOutlet weak var descriptionProductTxt: UITextView!
    
    var descriptionProduct: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Mô tả sản phẩm"
        
        // Hide keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        //Add rightBarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_integrate_dsp_info_check"), style: .plain, target: self, action: #selector(didTapSaveDescriptionProduct))
        
        if let descriptionProduct = self.descriptionProduct {
            descriptionProductTxt.text = descriptionProduct
        }
    }
    
    @objc func didTapSaveDescriptionProduct() {
        if let descriptionProduct = descriptionProductTxt.text {
            NotificationCenter.default.post(name: NSNotification.Name("postFromDescriptionProductVC"), object: descriptionProduct, userInfo: nil)
        }
        navigationController?.popViewController(animated: true)
    }
}
