//
//  ViewControllerFactory.swift
//  2048
//
//  Created by Mitesh Soni on 22/08/21.
//

import UIKit

/// Enum containing all the view controllers
enum ViewController {
    case home
    case game(userName: String)
}

/**
 Factory class responsible for creating and launching all the View Controllers.
 */
class ViewControllerFactory {
    
    // MARK: - Singleton  instance
    static let shared = ViewControllerFactory()
    
    
    // MARK:- Private init
    private init() {}
    
    
    // MARK:- Get View Controller
    
    /**
     Returns the appropriate view controller the the `ViewController` enum you pass.
     - Parameter viewController: `ViewController` enum value for the respective UIViewController.
     - Note: For most of the cases you will not need this you can call `push` and `present` functions with parameter `ViewController` enum directly on any `UIViewController`.
     */
    func getViewController(_ viewController: ViewController) -> UIViewController{
        switch viewController {
        case .home: return HomeViewController.instance()
        case .game(let userName): return createGameViewController(fromUserName: userName)
        }
    }

    
    // MARK:- Create View Controllers
    
    private func createGameViewController(fromUserName userName: String) -> GameViewController {
        let gameViewController: GameViewController = GameViewController.instance()
        gameViewController.setUser(userName)
        return gameViewController
    }
}


