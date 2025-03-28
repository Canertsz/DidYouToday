//
//  RecordDetailVM.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 27.03.2025.
//

import Foundation
import UIKit

protocol RecordDetailViewModelProtocol {
    func viewDidLoad()
    func answerButtonTapped()
    var activityName: String { get }
    var buttonText: String { get }
    var buttonColor: UIColor { get }
    var record: DidYou { get }
}

final class RecordDetailVM {
    private weak var view: RecordDetailViewProtocol?
    private let coordinator: RecordDetailCoordinatorProtocol
    let record: DidYou
    private var calendarViewModel: CalendarViewViewModelProtocol?
    
    init(view: RecordDetailViewProtocol, coordinator: RecordDetailCoordinatorProtocol, record: DidYou) {
        self.view = view
        self.coordinator = coordinator
        self.record = record
    }
    
    private func setupCalendarViewModel() -> CalendarViewViewModelProtocol {
        let calendarVM = CalendarViewVM(record: record)
        self.calendarViewModel = calendarVM
        return calendarVM
    }
}

// MARK: - RecordDetailViewModelProtocol
extension RecordDetailVM: RecordDetailViewModelProtocol {
    var activityName: String {
        return record.activityName ?? "Activity"
    }
    
    var buttonText: String {
        return record.buttonText ?? "Yes"
    }
    
    var buttonColor: UIColor {
        let colorString = record.buttonColor ?? "#000000"
        return UIColor(hexCode: colorString, alpha: 1.0)
    }
    
    func viewDidLoad() {
        view?.setupUI()
        view?.setupCalendar(with: setupCalendarViewModel())
    }
    
    func answerButtonTapped() {
        calendarViewModel?.addCurrentDate()
        view?.updateCalendar()
    }
}
