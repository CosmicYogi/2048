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
    case game
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
        case .game: return GameViewController.instance()
        // All the other cases would be handled here.
        }
    }

    
    // MARK:- Create View Controllers
    // Nothing a.t.m, We would write funcntions here for initializing view controllers which have some dependencies.
    // Would call those functions from `getViewController` corresponding to the respective ViewController enum.
}


