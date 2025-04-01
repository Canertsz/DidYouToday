//
//  ButtonBGColorPickerCell.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 7.03.2025.
//

import UIKit

final class ColorPickerColorCell: UICollectionViewCell {
    var color: String? {
        didSet {
            setBGColor()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        layer.cornerRadius = 6
        layer.masksToBounds = true
    }
    
    func setBGColor() {
        guard let color = color else { return }
        backgroundColor = UIColor.init(hex: color)
    }
}
