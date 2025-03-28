//
//  UIColor+Extension.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 27.03.2025.
//

import UIKit

extension UIColor {
    // Original initializer used in the app
    convenience init(hexCode: String, alpha: CGFloat) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
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
            alpha: alpha
        )
    }
    
    // New initializer for the RecordDetailVM
    convenience init?(hex: String) {
        let r, g, b: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }
        
        return nil
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
