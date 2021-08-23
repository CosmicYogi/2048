//
//  GlobalConstants.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

import UIKit

enum Constants {
    enum Display {
        static var safeAreaInsets: UIEdgeInsets {
            if #available(iOS 11.0, *) {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                return keyWindow?.safeAreaInsets ?? .zero
            } else {
                return UIEdgeInsets.zero
            }
        }
    }
    
}
