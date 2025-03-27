//
//  ButtonBGColorPicker.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 7.03.2025.
//

import UIKit

protocol ColorPickerViewProtocol: AnyObject {
    
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
        // make generic
        let nib = UINib(nibName: "ColorPickerView", bundle: Bundle.main)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
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
        // build constants struct. if there any, put calculations to vm
        return CGSize(width: 24, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.colorSelected(at: indexPath)
    }
    
}
