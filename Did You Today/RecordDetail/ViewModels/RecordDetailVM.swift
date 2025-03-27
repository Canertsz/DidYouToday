//
//  RecordDetailVM.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import Foundation

protocol RecordDetailViewModelProtocol {
    func viewDidLoad()
}

final class RecordDetailVM {
    private weak var view: RecordDetailViewProtocol?
    private let coordinator: RecordDetailCoordinator
    
    init(view: RecordDetailViewProtocol, coordinator: RecordDetailCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

// MARK: - RecordDetailViewModelProtocol
extension RecordDetailVM: RecordDetailViewModelProtocol {
    func viewDidLoad() {
        view?.setupUI()
        
    }
}
