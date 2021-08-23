//
//  UIViewController+Extensions.swift
//  2048
//
//  Created by Mitesh Soni on 22/08/21.
//

import UIKit

extension UIViewController {
    
    /**
     Instantiate the ViewController.
     - Note: - The ViewController to be created should have a corresponding Storyboard which is named the same view controller is. ViewController is also to be set **initial view controller**.
     */
    static func instance<T: UIViewController>() -> T {
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! T
        return controller
    }
}


// MARK: - Presenting and pushing

extension UIViewController {
    
    /**
     Pushes the passed `ViewController` to the navigation stack.
     - Parameter viewController: `ViewController` enum value for the respective UIViewController.
     */
    func push(_ viewController: ViewController, animated: Bool) {
        DispatchQueue.main.async {
            let viewController = ViewControllerFactory.shared.getViewController(viewController)
            self.navigationController?.pushViewController(viewController, animated: animated)
        }
    }
    
    /**
     Presents the passed `ViewController` on the current ViewController.
     - Parameter viewController: `ViewController` enum value for the respective UIViewController.
     */
    func present(_ viewController: ViewController, animated: Bool) {
        DispatchQueue.main.async {
            let viewController = ViewControllerFactory.shared.getViewController(viewController)
            self.present(viewController, animated: true)
        }
    }
    
    /**
     Sets the passed `ViewController` to the current navigation stack
     - Parameter viewController: `ViewController` enum value for the respective UIViewController.
     */
    func set(_ viewController: ViewController, animated: Bool = false) {
        DispatchQueue.main.async {
            let viewController = ViewControllerFactory.shared.getViewController(viewController)
            self.navigationController?.setViewControllers([viewController], animated: animated)
        }
    }
}
