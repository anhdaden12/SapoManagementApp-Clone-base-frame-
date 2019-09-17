//
//  RealIncomeVC.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 9/3/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class RealIncomeVC: UIViewController {

    @IBOutlet weak var navigationTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layoutIfNeeded()
        setupBackButton()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    fileprivate func setupBackButton() {
        let backImage = UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popnav))
    }
    
    @objc func popnav() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func ClickButtonArrowDown(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Thanh toán theo thời gian", style: .default) { (_) in
            self.navigationTitle.text = "Thanh toán theo thời gian"
        }
        
        let action2 = UIAlertAction(title: "Thanh toán theo phương thức", style: .default) { (_) in
            self.navigationTitle.text = "Thanh toán theo phương thức"
        }
        let action3 = UIAlertAction(title: "Thanh toán theo nhân viên", style: .default) { (_) in
            self.navigationTitle.text = "Thanh toán theo nhân viên"
        }
        let action4 = UIAlertAction(title: "Thanh toán theo chi nhánh", style: .default) { title in
            guard let aTitle = title.title else { return }
            self.navigationTitle.text = aTitle
        }
        
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(action4)
        
        present(actionSheet, animated: true, completion: {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dissmiss))
            actionSheet.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        })
    }
    
    
    @objc func dissmiss(){
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onClickCalendar(_ sender: Any) {
        let vc = UIStoryboard(name: "Report", bundle: nil).instantiateViewController(withIdentifier: "adjustVC")
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        present(vc, animated: true, completion: nil)
    }
    

}
