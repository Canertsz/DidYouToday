//
//  Array+Extension.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 7.03.2025.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
