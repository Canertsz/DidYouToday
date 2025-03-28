//
//  ButtonBGColorPicker.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 7.03.2025.
//

import UIKit

protocol ColorPickerViewProtocol: AnyObject {
    
}

extension ColorPickerView {
    enum constants {
        static let collectionViewItemWidth: CGFloat = 24.0
        static let collectionViewItemHeight: CGFloat = 24.0
    }
}

final class ColorPickerView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ColorPickerViewModelProtocol? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        loadFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(nibWithCellClass: ColorPickerColorCell.self)
    }
}

extension ColorPickerView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.numberOfItemsInSection ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ColorPickerColorCell.self, indexPath: indexPath)
        guard let color = viewModel?.arguments(for: indexPath)?.colorHex else { return cell }
        cell.color = color
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: constants.collectionViewItemWidth, height: constants.collectionViewItemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.colorSelected(at: indexPath)
    }
    
}
