//
//  NumpadViewController.swift
//  SapoAdmin
//
//  Created by Ngoc on 8/5/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class NumpadViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var numberPadView: UIView!
    let maxNumber = 9999999999
    var callback: ((Int) -> Void)?
    
    var displayNumber: Int = 0 {
        didSet {
            if displayNumber > maxNumber {
                temp = String(maxNumber)
                displayLabel.textColor = UIColor.red
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.displayLabel.textColor = UIColor.black
                }
            } else {
                displayLabel?.text = displayNumber.delimiter
            }
        }
    }
    var temp = "" {
        didSet {
            displayNumber = Int(temp) ?? 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayNumber.delimiter
        titleLabel.text = title
    }
    
    @IBAction func OnclickCancel(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Action
    @IBAction func onClickedDeleteOnce(_ sender: UIButton) {
        if displayNumber > 0 {
            temp.removeLast()
        }
    }
    
    @IBAction func clickedDeleteAll(_ sender: UIButton) {
        temp = ""
    }
    
    @IBAction func onCLickNumber(_ sender: UIButton) {
        guard displayNumber <= maxNumber else {return}
        temp += sender.currentTitle!
    }
    
    @IBAction func conClickConfirm(_ sender: Any) {
        callback?(displayNumber)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickOutOfView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
