//
//  GridCell.swift
//  2048
//
//  Created by Mitesh Soni on 21/08/21.
//

import UIKit

class GridCell: UICollectionViewCell {
    
    private let numberLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        _init()
    }
    
    private func _init() {
        initViews()
    }
    
    private func initViews() {
        addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4).isActive = true
        numberLabel.textAlignment = .center
    }
    
    func set(number: Int) {
        numberLabel.text = String(number)
    }
}
