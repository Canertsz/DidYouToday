//
//  RecordCell.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 26.03.2025.
//

import UIKit

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
        // Add corner radius to the content view
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        // Configure the cell for a card-like appearance
        backgroundColor = .clear
        selectionStyle = .none
        
        // Make sure the background color is set on the content view
    }
    
    // Add padding around the cell
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the insets for padding around the cell
        let padding: CGFloat = 8
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }
    
    private func configureUI() {
        activityTitleLabel.text = viewModel?.title
        streakTextLabel.text = viewModel?.streak
    }
}
