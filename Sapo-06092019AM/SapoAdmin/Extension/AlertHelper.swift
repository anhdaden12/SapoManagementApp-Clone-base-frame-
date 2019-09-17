//
//  AlertHelper.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 8/27/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//



import UIKit

//import SystemConfiguration



//func showAlertToDeleteApp(title:String, message: String) {
//    showAlertCompelete(title: title, message: message, settingsUrl: "App-prefs:root=General&path=STORAGE_ICLOUD_USAGE/DEVICE_STORAGE")
//}
//func showAlertToOpenSetting( title:String, message: String) {
//    showAlertCompelete(title: title, message: message, settingsUrl: UIApplication.openSettingsURLString)
//    
//}

func showAlert(title:String, message: String, vc: UIViewController, completeHandler: (() -> Void)? = nil ) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (result : UIAlertAction) -> Void in
        completeHandler?()
    }
    alertController.addAction(okAction)
    vc.present(alertController, animated: true, completion: nil)

}

func showAlertCompelete(title:String, message: String, settingsUrl: String, vc: UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let settingAction = UIAlertAction(title: "Setting", style: .cancel) { (_) -> Void in
        guard let settingsUrl = URL(string: settingsUrl) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.openURL(settingsUrl)
            } else {
                
            }
        }
    }
    let okAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
    }
    alertController.addAction(okAction)
    alertController.addAction(settingAction)
        vc.present(alertController, animated: true, completion: nil)
    
}


