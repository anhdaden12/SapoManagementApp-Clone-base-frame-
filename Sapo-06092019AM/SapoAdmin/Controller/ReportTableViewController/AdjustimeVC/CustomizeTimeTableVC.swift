//
//  ViewController4.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit




class CustomizeTimeTableVC: BaseCustomeTimeTableVC {
    
    static let instance = CustomizeTimeTableVC.fromNib(bundle: nil, storyboardName: "Report", identifier: "CustomizeTimeTableVC")

    override var userDefaultKey : String {
        return "CustomTimeAdjustmentIndex"
    }
    
    private var _listTime =  [
        Time(title: "Ngày bắt đầu", detail: "29 thg 8"),
        Time(title: "Ngày kết thúc", detail: "29 thg 8")
    ]
    
    override var listTime: [Time] {
        return _listTime
    }

    
}
