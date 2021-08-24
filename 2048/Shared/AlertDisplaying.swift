//
//  AlertDisplaying.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

import UIKit

/// Any **UIViewController** can implement this protocol and start utilizing the alert displaying implementation it provides.
protocol AlertDisplaying {
    func showAlert(withTitle: String, message: String, actionText: String, action: @escaping () -> Void)
}

extension AlertDisplaying where Self: UIViewController {
    func showAlert(withTitle title: String, message: String, actionText: String, action: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionText, style: .default) { _ in
            action()
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

