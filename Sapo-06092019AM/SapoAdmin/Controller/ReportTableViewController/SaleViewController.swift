//
//  SaleViewController.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/23/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class SaleViewController: UITableViewController {
    
    static var instance: SaleViewController = {
        return UIStoryboard(name: "Report", bundle: nil).instantiateViewController(withIdentifier: "saleVC") as! SaleViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func calendar(_ sender: Any) {
        let vc = UIStoryboard(name: "Report", bundle: nil).instantiateViewController(withIdentifier: "adjustVC")
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickRealIcome(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Report", bundle: nil).instantiateViewController(withIdentifier: "RealIncomeVC") as! RealIncomeVC
        navigationController?.pushViewController(storyboard, animated: true)
        
    }
    
}
