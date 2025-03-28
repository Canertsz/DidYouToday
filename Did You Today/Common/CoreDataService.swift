//
//  CoreDataService.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 26.03.2025.
//

import Foundation
import UIKit

protocol CoreDataServiceProtocol {
    static func addCoreData(activityName: String, buttonColor: String, buttonText: String, notificationTime: Date?) -> DidYou?
    static func fetchCoreData(onSuccess: @escaping ([DidYou]?) -> Void)
    static func deleteCoreData(indexPath: Int, items: [DidYou])
}

class CoreDataService: CoreDataServiceProtocol {
    static func addCoreData(activityName: String, buttonColor: String, buttonText: String, notificationTime: Date?) -> DidYou? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newRecord = DidYou(context: context)
        
        newRecord.activityName = activityName
        newRecord.buttonColor = buttonColor
        newRecord.notificationTime = notificationTime
        newRecord.buttonText = buttonText
        
        do {
            try context.save()
            return newRecord
        } catch {
            print("error-Saving data")
            return nil
        }
    }
    
    static func fetchCoreData(onSuccess: @escaping ([DidYou]?) -> Void) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let items = try context.fetch(DidYou.fetchRequest()) as? [DidYou]
            onSuccess(items)
        } catch {
            print("error-Fetching data")
        }
    }
    
    static func deleteCoreData(indexPath: Int, items: [DidYou]) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let dataToRemove = items[indexPath]
        context.delete(dataToRemove)
        do {
            try context.save()
        } catch {
            print("error-Deleting data")
        }
    }
}
