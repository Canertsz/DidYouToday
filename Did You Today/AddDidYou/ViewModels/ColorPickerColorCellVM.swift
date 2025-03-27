//
//  ColorPickerColorCellVM.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 14.03.2025.
//

final class ColorPickerColorCellViewModel {
    private let arguments: Arguments
    
    init(arguments: ColorPickerColorCellViewModel.Arguments) {
        self.arguments = arguments
    }
}

extension ColorPickerColorCellViewModel {
    struct Arguments {
        let colorHex: String
    }
}
