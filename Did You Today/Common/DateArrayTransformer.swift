//
//  DateArrayTransformer.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 27.03.2025.
//

import Foundation

@objc(DateArrayTransformer)
class DateArrayTransformer: NSSecureUnarchiveFromDataTransformer {
    
    static let name = NSValueTransformerName(rawValue: String(describing: DateArrayTransformer.self))
    
    override static var allowedTopLevelClasses: [AnyClass] {
        return [NSArray.self, NSDate.self]
    }
    
    public static func register() {
        let transformer = DateArrayTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
} 