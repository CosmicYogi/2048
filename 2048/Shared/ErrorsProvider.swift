//
//  ErrorsProvider.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

import Foundation

/// Provides all the errors used by the app
enum ErrorsProvider {
    static let invalidUser = NSError(domain: "Sorry, Please enter a valid username.", code: 0, userInfo: nil)
}
