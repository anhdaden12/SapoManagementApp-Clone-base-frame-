//
//  AdjustTimeVC.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

protocol AdjustTimePageVCDelegate: class {
    func setSelectedIndex(sender: UIViewController, selectedIndex: Int)
}

class AdjustTimeVC: UIViewController, AdjustTimePageVCDelegate {
    
    
    private var selectedTimeIndex: Int = 1 {
        didSet {
            let sender = headerButtons[selectedTimeIndex]
            UIView.animate(withDuration: 0.35) {
                self.buttonLine.frame = CGRect(x: sender.frame.minX, y: sender.frame.maxY, width: sender.frame.width, height: 2)
                for i in self.headerButtons {
                    i.titleLabel?.textColor = .gray
                }
                sender.titleLabel?.tintColor = .blue
            }
        }
    }
    
    @IBOutlet var headerButtons: [UIButton]!
    
    @IBOutlet weak var buttonLine: UIView!
    
    weak var pageVc: AdjusttimePageViewVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let sender = headerButtons[selectedTimeIndex]
        self.buttonLine.frame = CGRect(x: sender.frame.minX, y: sender.frame.maxY, width: sender.frame.width, height: 2)
        view.layoutIfNeeded()
        pageVc?.selectedIndex = selectedTimeIndex
        
        
        
        for i in self.headerButtons {
            i.titleLabel?.textColor = .gray
        }
        sender.titleLabel?.tintColor = .blue
    }
    
    
    @IBAction func ClickButton(_ sender: UIButton) {
        
        let selectedIndex = headerButtons.firstIndex(of: sender) ?? 0
        setSelectedIndex(sender: self, selectedIndex: selectedIndex)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier ?? "" {
        case segueidentifier.embedadjustVc.rawValue:
            pageVc = segue.destination as? AdjusttimePageViewVC
            pageVc?.indexDelegate = self
            
        default:
            return
        }
        
    }
    
    
    func setSelectedIndex(sender: UIViewController, selectedIndex: Int) {
        
        if sender === self {
            pageVc?.selectedIndex = selectedIndex
        }
        self.selectedTimeIndex = selectedIndex
    }
    
    
    @IBAction func canCelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

enum segueidentifier: String {
    case embedadjustVc = "embedadjustVc"
}

