//
//  RecordCell.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 26.03.2025.
//

import UIKit

extension RecordCell {
    enum constants {
        static let cellCornerRadius: CGFloat = 10
        static let cellPadding: CGFloat = 8
    }
}

final class RecordCell: UITableViewCell {
    var viewModel: RecordCellViewModelProtocol? {
        didSet {
            configureUI()
        }
    }
    
    @IBOutlet weak var activityTitleLabel: UILabel!
    @IBOutlet weak var streakTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        contentView.layer.cornerRadius = constants.cellCornerRadius
        contentView.layer.masksToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = constants.cellPadding
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }
    
    private func configureUI() {
        activityTitleLabel.text = viewModel?.title
        streakTextLabel.text = viewModel?.streak
    }
}
