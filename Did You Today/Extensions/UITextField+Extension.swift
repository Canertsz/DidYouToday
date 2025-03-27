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
        
        // The border should be inside the text field
        // so I changed frame.size.height + 5 to
        // frame.size.height - 1
        bottomLine.frame = CGRect(x: 0,
                                  y: frame.size.height-1,
                                  width: frame.size.width,
                                  height: 0.5)
        
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        
        borderStyle = .none
        
        layer.addSublayer(bottomLine)
        
        // Add this so the layer does not go beyond the
        // bounds of the text field
        layer.masksToBounds = true
    }
}
