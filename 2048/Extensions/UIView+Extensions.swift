//
//  UIView+Extensions.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

import UIKit

// MARK: - Keyboard Management

extension UIView {
    func animateWithKeyboard(notification: NSNotification, constraint: NSLayoutConstraint, constant: CGFloat) {
        let userInfo = notification.userInfo
        let keyboardFrameKey = UIResponder.keyboardFrameEndUserInfoKey
        let keyboardFrameValue = userInfo?[keyboardFrameKey] as? NSValue
        let keyboardFrameRect = keyboardFrameValue?.cgRectValue ?? CGRect.zero
        let keyboardFrameHeight = keyboardFrameRect.height
        let duration = userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let options = AnimationOptions(rawValue: curve)
        
        let targetHeight: CGFloat
        switch notification.name {
        case UIResponder.keyboardWillHideNotification:
            targetHeight = constant
        default:
            let bottomInset = Constants.Display.safeAreaInsets.bottom
            targetHeight = max(constant, keyboardFrameHeight + constant - bottomInset)
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: options) {
            constraint.constant = targetHeight
            self.layoutIfNeeded()
        }

    }
}
