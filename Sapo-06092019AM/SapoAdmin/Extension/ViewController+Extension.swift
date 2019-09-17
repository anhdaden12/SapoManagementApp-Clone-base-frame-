

//
//  UIViewControllerExtension.swift
//
//  Created by Minh.Thang on 4/28/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

extension UIViewController {
    //init Controller
    class func fromNib<T: UIViewController>(bundle: Bundle? = nil, storyboardName: String? = nil, identifier: String?) -> T {
        let storyboard = UIStoryboard(name: storyboardName ?? "Main", bundle: (bundle ?? Bundle.main))
        return storyboard.instantiateViewController(withIdentifier: String(describing: identifier!)) as! T
    }
    
    
        
    func setAsRootViewController() {
        let originalVC = UIApplication.shared.keyWindow?.rootViewController
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: { () -> Void in
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = self
            UIView.setAnimationsEnabled(oldState)
        }){ _ in
            originalVC?.dismiss(animated: false, completion: nil)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
