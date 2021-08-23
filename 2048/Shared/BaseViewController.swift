//
//  BaseViewController.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

import UIKit

/**
 Parent View Controller for most of all the View Controllers.
 */
class BaseViewController: UIViewController {
    
    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _init()
    }
    
    
    // MARK: - Initial setup
    
    private func _init() {
        subscribeForEvents()
    }
    
    private func subscribeForEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - Keyboard Management
    
    func hideKeyboardOnAction(inView view: UIView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditingForcefully))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func endEditingForcefully() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) { }
    @objc func keyboardWillHide(notification: NSNotification) { }
}
