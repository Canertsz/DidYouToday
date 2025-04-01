//
//  UIColor+Extension.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 27.03.2025.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, ColorError.invalidHEXCode.localizedDescription)
        
        var rgbColorValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbColorValue)
        
        self.init(
            red: CGFloat((rgbColorValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbColorValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbColorValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
    
    static func fromHex(_ hex: String) -> UIColor? {
        return UIColor(hex: hex)
    }
}

enum ColorError: LocalizedError {
    case invalidHEXCode
    
    var errorDescription: String? {
        switch self {
        case .invalidHEXCode:
            return "Use of invalid HEX CODE value."
        }
    }
}
