//
//  CoreDataService.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 26.03.2025.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataServiceProtocol {
    func addCoreData(activityName: String, buttonColor: String, buttonText: String, notificationTime: Date?) -> DidYou?
    func fetchCoreData(onSuccess: @escaping ([DidYou]?) -> Void)
    func deleteCoreData(indexPath: Int, items: [DidYou])
    func getRecord(by objectID: NSManagedObjectID) -> DidYou?
}

class CoreDataService: CoreDataServiceProtocol {
    static let shared = CoreDataService()
    
    var contextProvider: () -> NSManagedObjectContext = {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func addCoreData(activityName: String, buttonColor: String, buttonText: String, notificationTime: Date?) -> DidYou? {
        let context = contextProvider()
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
    
    func fetchCoreData(onSuccess: @escaping ([DidYou]?) -> Void) {
        let context = contextProvider()
        do {
            let items = try context.fetch(DidYou.fetchRequest()) as? [DidYou]
            onSuccess(items)
        } catch {
            print("error-Fetching data")
        }
    }
    
    func deleteCoreData(indexPath: Int, items: [DidYou]) {
        let context = contextProvider()
        let dataToRemove = items[indexPath]
        context.delete(dataToRemove)
        do {
            try context.save()
        } catch {
            print("error-Deleting data")
        }
    }
    
    func getRecord(by objectID: NSManagedObjectID) -> DidYou? {
        let context = contextProvider()
        do {
            return try context.existingObject(with: objectID) as? DidYou
        } catch {
            print("error-Fetching record by objectID: \(error)")
            return nil
        }
    }
}

// Static wrapper methods for backward compatibility with existing code
extension CoreDataService {
    static func addCoreData(activityName: String, buttonColor: String, buttonText: String, notificationTime: Date?) -> DidYou? {
        return shared.addCoreData(activityName: activityName, buttonColor: buttonColor, buttonText: buttonText, notificationTime: notificationTime)
    }
    
    static func fetchCoreData(onSuccess: @escaping ([DidYou]?) -> Void) {
        shared.fetchCoreData(onSuccess: onSuccess)
    }
    
    static func deleteCoreData(indexPath: Int, items: [DidYou]) {
        shared.deleteCoreData(indexPath: indexPath, items: items)
    }
    
    static func getRecord(by objectID: NSManagedObjectID) -> DidYou? {
        return shared.getRecord(by: objectID)
    }
}
