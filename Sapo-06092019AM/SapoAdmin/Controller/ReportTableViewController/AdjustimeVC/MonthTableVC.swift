//
//  ViewController3.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class MonthTableVC: BaseCustomeTimeTableVC {
    static let instance = MonthTableVC.fromNib(bundle: nil, storyboardName: "Report", identifier: "MonthTableVC")

    override var userDefaultKey : String {
        return "MonthAdjustmentIndex"
    }
    
    private var _listTime =  [
        Time(title: "30 ngày qua", detail: "23 thg 8 - 23 thg 9"),
        Time(title: "Tháng này", detail: "26 thg 8 - 26 thg 9"),
        Time(title: "Tháng trước", detail: "19 thg 8 - 25 thg 9")
    ]
    
    override var listTime: [Time] {
        return _listTime
    }
    
    
}
