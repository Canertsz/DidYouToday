//
//  ColorPickerVM.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 6.03.2025.
//

import Foundation

protocol ColorPickerViewModelProtocol {
    func loadView()
    func colorSelected(at index: IndexPath)
    func arguments(for indexPath: IndexPath) -> ColorPickerColorCellViewModel.Arguments?
    var numberOfItemsInSection: Int { get }
}

protocol ColorPickerViewModelDelegate: AnyObject {
    func didSelectColor(hex: String)
}

final class ColorPickerViewModel {
    private let colors: [Color] = Color.allCases
    private weak var delegate: ColorPickerViewModelDelegate?
    
    init(delegate: ColorPickerViewModelDelegate? = nil) {
        self.delegate = delegate
    }
}

// MARK: - ColorPickerViewModelProtocol
extension ColorPickerViewModel: ColorPickerViewModelProtocol {
    func loadView() {
        
    }
    
    func arguments(for indexPath: IndexPath) -> ColorPickerColorCellViewModel.Arguments? {
        guard let selectedColor = colors[safe: indexPath.row] else { return nil }
        return .init(colorHex: selectedColor.hex)
    }
    
    func colorSelected(at index: IndexPath) {
        guard let color = colors[safe: index.row] else { return }
        delegate?.didSelectColor(hex: color.hex)
    }
    
    var numberOfItemsInSection: Int { colors.count }
}

private extension ColorPickerViewModel {
    enum Color: CaseIterable {
        case black
        case green
        case blue
        case red
        case orange
        
        var hex: String {
            switch self {
                case .black:
                    return "#000000"
                case .green:
                    return "#00FF00"
                case .blue:
                    return "#0000FF"
                case .red:
                    return "#FF0000"
                case .orange:
                    return "#FFA500"
            }
        }
    }
}
