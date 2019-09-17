//
//  ReportTableViewController.swift
//  SapoAdmin
//
//  Created by Minh Thang on 8/2/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class ReportTableViewController: UIViewController, ViewControllerDescription, PageViewControllerDelegate {
    
    var orderInTabbar: Int = 2
    
    var selectedItem: Int = 0 {
        didSet {
            setButtonLineAfterSelected()
        }
    }
    
    fileprivate func setButtonLineAfterSelected() {
        let selectedView = viewOutside[self.selectedItem]
        let selectedLabel = contentButtons[self.selectedItem]
        
        // Set default color and font of Lable
        for i in contentButtons {
            i.textColor = .black
            i.font = UIFont(name: "Helvetica-Regular", size: 13)
        }
        
        // Change color and Font of Lable did selected
        selectedLabel.font = UIFont(name: "Helvetica-Bold", size: 17)
        UIView.animate(withDuration: 0.3) {
            self.buttonLine.frame = CGRect(x: selectedView.frame.midX - 0.4 * selectedLabel.frame.width, y: selectedView.frame.midY + 0.65 * selectedLabel.frame.height, width: selectedLabel.frame.width * 0.8, height: 2)
            selectedLabel.textColor = #colorLiteral(red: 0.006370984018, green: 0.4774341583, blue: 0.9984987378, alpha: 1)
        }
        
    }
    
    @IBOutlet var headerButtons : [UIButton]!
    @IBOutlet var contentButtons: [UILabel]!
    @IBOutlet var viewOutside: [UIView]!
    @IBOutlet weak var buttonLine : UIView!
    
    let defaultIndex = 0
    
    weak var pageVC: PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDefaultButtonLine()
        pageVC?.selectedIndex = self.selectedItem
    }
    
    fileprivate func setDefaultButtonLine() {
        for i in contentButtons {
            i.textColor = .black
            i.font = UIFont(name: "Helvetica-Regular", size: 13)
        }
        let selectedView = viewOutside[self.selectedItem]
        let selectedLabel = contentButtons[self.selectedItem]
        self.buttonLine.frame = CGRect(x: selectedView.frame.midX - 0.4 * selectedLabel.frame.width, y: selectedView.frame.midY + 0.65 * selectedLabel.frame.height, width: selectedLabel.frame.width * 0.8, height: 2)
        selectedLabel.textColor = #colorLiteral(red: 0.006370984018, green: 0.4774341583, blue: 0.9984987378, alpha: 1)
        selectedLabel.font = UIFont(name: "Helvetica-Bold", size: 17)
    }

    @IBAction func onClickInsideButton(sender: UIButton) {
        selectedItem = headerButtons.firstIndex(of: sender)!
        selectedItemFromPageViewController(selectedItem, from: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        pageVC = segue.destination as? PageViewController //
        pageVC?.indexDelegate = self //
    }
    
    func selectedItemFromPageViewController(_ selected: Int, from viewController: UIViewController) {
        if viewController == self {
            pageVC?.selectedIndex = selected
        }
        self.selectedItem = selected
    }
    
}

class ReportNavigationController: UINavigationController {
    
    static var instance : ReportNavigationController = {
        let storyboard = UIStoryboard(name: "Report", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ReportNavigationController") as! ReportNavigationController
    }()
    
}
