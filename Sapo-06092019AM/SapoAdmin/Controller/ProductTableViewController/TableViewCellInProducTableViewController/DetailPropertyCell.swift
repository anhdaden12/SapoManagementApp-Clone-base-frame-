//
//  DetailPropertyCell.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class DetailPropertyCell: UITableViewCell {

    var callBack: (() -> Void)?
    
    @IBOutlet weak var propertyTextField: UITextField!
    @IBOutlet weak var listAttributedTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func didTapAddProperty(_ sender: Any) {
        self.callBack?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
