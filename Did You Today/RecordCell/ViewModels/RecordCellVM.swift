//
//  RecordCellVM.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 26.03.2025.
//

import Foundation

protocol RecordCellViewModelProtocol {
    var title: String { get }
    var streak: String { get }
}

final class RecordCellVM {
    private let record: DidYou
    
    init(record: DidYou) {
        self.record = record
    }
    
}

// MARK: - RecordCellViewModelProtocol
extension RecordCellVM: RecordCellViewModelProtocol {
    var title: String {
        return record.activityName ?? "Activity"
    }
    
    var streak: String {
        return "0"
    }
}
