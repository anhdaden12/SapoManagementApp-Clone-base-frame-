//
//  ProductVersionTableViewCell.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class DetailProductVersionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameOfProductVersion: UILabel!
    @IBOutlet weak var retailPrice: UILabel!
    @IBOutlet weak var producCode: UILabel!
    @IBOutlet weak var inventory: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
