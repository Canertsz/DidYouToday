//
//  NotificationService.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.03.2025.
//

import Foundation
import UserNotifications
import CoreData
import UIKit

class NotificationService {
    
    static let shared = NotificationService()
    
    private init() {}
    
    // Permissions
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification Permission Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            completion(granted)
        }
    }
    
    // Schedule notification
    func scheduleNotification(for record: DidYou) {
        guard let activityName = record.activityName,
              let notificationTime = record.notificationTime else {
            print("Cannot schedule notification: Missing activity name or notification time")
            return
        }
        
        let recordIDString = record.objectID.uriRepresentation().absoluteString
        let notificationId = "didyou-\(activityName.lowercased().replacingOccurrences(of: " ", with: "-"))"
        
        cancelNotification(withId: notificationId)
        
        let content = UNMutableNotificationContent()
        content.title = "Did You Today"
        content.body = "Did you \(activityName) today?"
        content.sound = .default
        
        content.userInfo = ["recordID": recordIDString]
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: notificationTime)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Successfully scheduled notification for '\(activityName)' at \(notificationTime)")
            }
        }
    }
    
    func getRecordFromNotification(_ notification: UNNotification) -> DidYou? {
        return getRecordFromUserInfo(notification.request.content.userInfo)
    }
    
    func getRecordFromNotificationResponse(_ response: UNNotificationResponse) -> DidYou? {
        return getRecordFromUserInfo(response.notification.request.content.userInfo)
    }
    
    // Helper method to extract record from userInfo
    private func getRecordFromUserInfo(_ userInfo: [AnyHashable: Any]) -> DidYou? {
        guard let recordIDString = userInfo["recordID"] as? String,
              let url = URL(string: recordIDString),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let coordinator = appDelegate.persistentContainer.persistentStoreCoordinator
        
        do {
            guard let objectID = coordinator.managedObjectID(forURIRepresentation: url) else {
                return nil
            }
            
            let record = try context.existingObject(with: objectID)
            return record as? DidYou
        } catch {
            print("Error retrieving record: \(error)")
            return nil
        }
    }
    
    func cancelNotification(withId id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func scheduleAllNotifications() {
        CoreDataService.fetchCoreData { records in
            guard let records else { return }
            
            for record in records {
                if record.notificationTime != nil {
                    self.scheduleNotification(for: record)
                }
            }
        }
    }
} 
