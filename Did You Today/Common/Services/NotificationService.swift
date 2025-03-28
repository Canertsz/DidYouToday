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
    
    // Request notification permissions
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
    
    // Schedule a notification for a specific record
    func scheduleNotification(for record: DidYou) {
        guard let activityName = record.activityName,
              let notificationTime = record.notificationTime else {
            print("Cannot schedule notification: Missing activity name or notification time")
            return
        }
        
        // Get record's objectID string for later retrieval
        let recordIDString = record.objectID.uriRepresentation().absoluteString
        
        // Create a unique identifier for this notification based on the record
        let notificationId = "didyou-\(activityName.lowercased().replacingOccurrences(of: " ", with: "-"))"
        
        // Remove any existing notifications with this ID
        cancelNotification(withId: notificationId)
        
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Did You Today"
        content.body = "Did you \(activityName) today?"
        content.sound = .default
        
        // Add the record's objectID to the notification's userInfo
        content.userInfo = ["recordID": recordIDString]
        
        // Extract hour and minute components from the notificationTime
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: notificationTime)
        
        // Create a daily trigger at the specified time
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        // Create the request
        let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Successfully scheduled notification for '\(activityName)' at \(notificationTime)")
            }
        }
    }
    
    // Get record from notification userInfo
    func getRecordFromNotification(_ notification: UNNotification) -> DidYou? {
        return getRecordFromUserInfo(notification.request.content.userInfo)
    }
    
    // Get record from notification response
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
    
    // Cancel a specific notification
    func cancelNotification(withId id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    // Cancel all notifications for the app
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    // Schedule notifications for all records with notification times
    func scheduleAllNotifications() {
        CoreDataService.fetchCoreData { records in
            guard let records = records else { return }
            
            for record in records {
                if record.notificationTime != nil {
                    self.scheduleNotification(for: record)
                }
            }
        }
    }
} 
