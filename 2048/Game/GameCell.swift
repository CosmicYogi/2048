//
//  GameCell.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.borderWidth = 4
        layer.borderColor = UIColor.black.cgColor
    }
    
    func set(number: Int?) {
        numberLabel.text = number.map { String($0) }
    }
}
