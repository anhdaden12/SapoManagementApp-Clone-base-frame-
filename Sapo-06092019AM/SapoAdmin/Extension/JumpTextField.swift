//
//  JumpTextField.swift
//  SapoAdmin
//
//  Created by Minh.Thang on 9/5/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

/**
 A JumpTextField is a subclass of the TextFieldEffects object, is a control that displays an UITextField with a customizable visual effect around the edges of the control.
 */
@IBDesignable open class JumpTextField : TextFieldEffects {
    private let borderSize: (active: CGFloat, inactive: CGFloat) = (1, 2)
    private let borderLayer = CALayer()
    private let textFieldInsets = CGPoint(x: 0, y: 0)
    private let placeholderInsets = CGPoint(x: 0, y: 0)
    private let timeForAnimate = 0.3
    

    /**
     The color of the placeholder text.
     
     This property applies a color to the complete placeholder string. The default value for this property is a black color.
     */
    @objc dynamic open var placeholderColor: UIColor = .lightGray {
        didSet {
            updatePlaceholder()
        }
    }
    
    /**
     The scale of the placeholder font.
     
     This property determines the size of the placeholder label relative to the font size of the text field.
     */
    @IBInspectable dynamic open var placeholderFontScaleForTextDisplay: CGFloat = 1.0 {
        didSet {
            updatePlaceholder()
        }
    }
    
    @IBInspectable dynamic open var placeholderFontScaleForTextEntry: CGFloat = 0.8 {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            updateBorder()
        }
    }
    
    // MARK: TextFieldEffects
    
    override open func drawViewsForRect(_ rect: CGRect) {
        updateBorder()
        updatePlaceholder()
        
        addSubview(placeholderLabel)
        layer.addSublayer(borderLayer)
    }
    
    override open func animateViewsForTextEntry() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
            self.placeholderLabel.textColor = UIColor.blue
            self.placeholderLabel.font = self.placeholderFontFromBack(self.font!)
        }, completion: { _ in
            self.animationCompletionHandler?(.textEntry)
        })
    }
    
    override open func animateViewsForTextDisplay() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
            self.placeholderLabel.textColor = self.placeholderColor
            self.placeholderLabel.font = self.placeholderFontFromFont(self.font!)
        }, completion: { _ in
            self.animationCompletionHandler?(.textDisplay)
        })
    }
    
    // MARK: Private
    
    private func updatePlaceholder() {
        placeholderLabel.frame = placeholderRect(forBounds: bounds)
        placeholderLabel.text = placeholder
        placeholderLabel.textAlignment = textAlignment
        if let text = text, text.isNotEmpty {
            self.placeholderLabel.textColor = UIColor.blue
            self.placeholderLabel.font = self.placeholderFontFromBack(self.font!)
        }else{
            self.placeholderLabel.textColor = self.placeholderColor
            self.placeholderLabel.font = self.placeholderFontFromFont(self.font!)
        }
    }
    
    private func updateBorder() {
        borderLayer.frame = rectForBounds(bounds)
        borderLayer.borderWidth = (isFirstResponder || text!.isNotEmpty) ? borderSize.active : borderSize.inactive
        borderLayer.borderColor = borderColor?.cgColor
    }
    // To change font size
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * placeholderFontScaleForTextDisplay)
        return smallerFont
    }
    
    private func placeholderFontFromBack(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * placeholderFontScaleForTextEntry)
        return smallerFont
    }
    
    //
    
    private var placeholderHeight : CGFloat {
        return placeholderInsets.y + placeholderFontFromFont(font!).lineHeight
    }
    
    private func rectForBounds(_ bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y + placeholderHeight, width: bounds.size.width, height: bounds.size.height - placeholderHeight)
    }
    
    // MARK: - Overrides
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if text!.isNotEmpty {
            return CGRect(x: placeholderInsets.x, y: placeholderInsets.y, width: bounds.width, height: placeholderHeight)
        } else {
            return textRect(forBounds: bounds)
        }
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y + placeholderHeight/2)
    }
}
