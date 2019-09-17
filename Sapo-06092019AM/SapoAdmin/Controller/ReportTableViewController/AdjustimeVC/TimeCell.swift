//
//  TimeCell.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class TimeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textLabel?.font = UIFont.init(name: "Helvetica-Bold", size: 17)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
