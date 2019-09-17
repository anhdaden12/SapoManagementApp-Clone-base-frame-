//
//  FormatterInt.swift
//  SapoAdmin
//
//  Created by Ngoc on 8/7/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit
var numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter
}()

extension Int {
    var delimiter: String {
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Double {
    var delimiter: String {
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

