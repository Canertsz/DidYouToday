//
//  RecordDetailVC.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import UIKit

protocol RecordDetailViewProtocol: AnyObject {
    func setupUI()
}

final class RecordDetailVC: UIViewController {
    
    var viewModel: HomeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

// MARK: - RecordDetailViewProtocol
extension RecordDetailVC: RecordDetailViewProtocol {
    func setupUI() {
        
    }
}

extension RecordDetailVC: StoryboardInstantiable {
    static var storyboardName: String { "RecordDetail" }
    static var identifier: String { "RecordDetailVC" }
}
