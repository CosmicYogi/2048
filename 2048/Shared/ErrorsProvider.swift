//
//  ErrorsProvider.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

import Foundation

enum ErrorsProvider {
    static let invalidUser = NSError(domain: "Sorry, Please enter a valid username.", code: 0, userInfo: nil)
}
