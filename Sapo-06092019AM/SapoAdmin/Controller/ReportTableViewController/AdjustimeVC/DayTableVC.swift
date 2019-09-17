//
//  ViewController1.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

struct Time {
    var title: String
    var detail: String
}

class DayTableVC: BaseCustomeTimeTableVC {
    static let instance = DayTableVC.fromNib(bundle: nil, storyboardName: "Report", identifier: "DayTableVC")

    override var userDefaultKey : String {
        return "DayAdjustmentIndex"
    }
    
    private var _listTime =  [
        Time(title: "Hôm nay", detail: "Thứ năm, 29 thg 8"),
        Time(title: "Hôm qua", detail: "Thứ tư, 28 thg 8")
    ]
    
    override var listTime: [Time] {
        return _listTime
    }
}

