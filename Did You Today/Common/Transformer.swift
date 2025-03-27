//
//  Transformer.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 26.03.2025.
//

import Foundation

class DateArrayTransformer: ValueTransformer {
    override class func allowsReverseTransformation() -> Bool {
        return true
    }

    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let dates = value as? [Date] else { return nil }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: dates, requiringSecureCoding: true)
            return data
        } catch {
            print("Failed to encode dates: \(error)")
            return nil
        }
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let dates = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSDate.self], from: data) as? [Date]
            return dates
        } catch {
            print("Failed to decode dates: \(error)")
            return nil
        }
    }
}
