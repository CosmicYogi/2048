//
//  FontProvider.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

import UIKit

/// Weights for **ClearSans** font
enum ClearSans: String {
    case bold = "Bold"
    case medium = "Medium"
    case regular = "Regular"
}

/// Enum containing all the fonts supported by app
enum Font {
    case system(weight: UIFont.Weight)
    case clearSans(weight: ClearSans)
}

/**
 Factory class responsible for creating all the fonts supported by the app
 */
class FontsProvider {
    
    // MARK: - Singleton instance
    static let shared = FontsProvider()
    
    
    // MARK: - Private init
    private init() { }
    
    
    // MARK: - Get font
    
    func getFont(_ font: Font, size: CGFloat) -> UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        switch font {
        case .system(let weight): return UIFont.systemFont(ofSize: size, weight: weight)
        case .clearSans(let weight): return UIFont(name: "ClearSans-\(weight)", size: size) ?? defaultFont
        }
    }
}
