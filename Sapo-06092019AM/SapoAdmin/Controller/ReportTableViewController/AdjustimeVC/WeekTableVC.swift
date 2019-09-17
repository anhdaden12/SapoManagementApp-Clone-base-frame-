//
//  ViewController2.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit



class WeekTableVC: BaseCustomeTimeTableVC {
    static let instance = WeekTableVC.fromNib(bundle: nil, storyboardName: "Report", identifier: "WeekTableVC")

    override var userDefaultKey : String {
        return "WeekAdjustmentIndex"
    }
    
    private var _listTime =  [
        Time(title: "7 ngày qua", detail: "23 thg 8 - 29 thg 8"),
        Time(title: "Tuần này", detail: "26 thg 8 - 29 thg 8"),
        Time(title: "Tuần trước", detail: "19 thg 8 - 25 thg 8")
    ]
    
    override var listTime: [Time] {
        return _listTime
    }
}
