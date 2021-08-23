//
//  GamePresenting.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

import UIKit

protocol GamePresenting {
    func present(welcomeMessage: NSAttributedString)
    func presentAlert(withTitle title: String, message: String)
    func update(grid: [[Int?]])
    func update(score: NSAttributedString)
}
