//
//  RootViewController.swift
//  2048
//
//  Created by Mitesh Soni on 22/08/21.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        set(.home)
    }
}
