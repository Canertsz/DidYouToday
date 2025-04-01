//
//  Extension+UITextField.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 4.03.2025.
//

import UIKit

extension UITextField
{
    func addBottomBorder() {
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0,
                                  y: frame.size.height-1,
                                  width: frame.size.width,
                                  height: 0.5)
        
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        
        borderStyle = .none
        layer.addSublayer(bottomLine)
        layer.masksToBounds = true
    }
}
