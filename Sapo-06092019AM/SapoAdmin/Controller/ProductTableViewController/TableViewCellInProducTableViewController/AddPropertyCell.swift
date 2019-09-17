//
//  AddPropertyCell.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class AddPropertyCell: UITableViewCell {

    var delegate: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func didTapAddProperty(_ sender: Any) {
        self.delegate?()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
