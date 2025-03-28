//
//  CalendarViewVM.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 27.03.2025.
//

import Foundation
import UIKit

protocol CalendarViewViewModelProtocol {
    var record: DidYou { get }
    var checkedDates: [Date] { get }
    func dateIsChecked(_ date: Date) -> Bool
    func addCurrentDate()
}

final class CalendarViewVM {
    let record: DidYou
    
    init(record: DidYou) {
        self.record = record

        if record.timeLogs == nil {
            record.timeLogs = [] as NSObject
            saveRecord()
        }
    }
    
    private func saveRecord() {
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            try context.save()
        } catch {
            print("error")
        }
    }
}

// MARK: - CalendarViewViewModelProtocol
extension CalendarViewVM: CalendarViewViewModelProtocol {
    var checkedDates: [Date] {
        guard let timeLogsData = record.timeLogs as? [Date] else {
            return []
        }
        return timeLogsData
    }
    
    func dateIsChecked(_ date: Date) -> Bool {
        let result = checkedDates.contains { checkedDate in
            Calendar.current.isDate(checkedDate, inSameDayAs: date)
        }
        return result
    }
    
    func addCurrentDate() {
        let currentDate = Date()
        
        if dateIsChecked(currentDate) {
            return
        }
        
        var dates = [Date]()
        dates.append(contentsOf: checkedDates)
        dates.append(currentDate)
        
        record.timeLogs = dates as NSObject
        
        saveRecord()
    }
}
