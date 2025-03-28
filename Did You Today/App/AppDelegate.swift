//
//  AppDelegate.swift
//  Did You Today
//
//  Created by Caner Tüysüz on 28.02.2025.
//

import UIKit
import CoreData
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // Reference to the app's main window for navigation
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ValueTransformer.setValueTransformer(DateArrayTransformer(), forName: NSValueTransformerName("DateArrayTransformer"))
        
        // Set up notification delegate
        UNUserNotificationCenter.current().delegate = self
        
        // Check if app was launched from a notification
        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            handleNotification(userInfo: notification)
        }
        
        // Schedule notifications for all records with notification times
        NotificationService.shared.scheduleAllNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Did_You_Today")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Navigate to record detail screen
    func navigateToRecordDetail(_ record: DidYou) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Get the root navigation controller if using SceneDelegate
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate,
                  let window = sceneDelegate.window,
                  let rootViewController = window.rootViewController as? UINavigationController else {
                print("Could not find root navigation controller")
                return
            }
            
            // Check if already on HomeVC
            let topVC = rootViewController.topViewController
            if topVC is HomeVC {
                // Navigate directly from HomeVC
                let homeVC = topVC as! HomeVC
                homeVC.navigateToRecordDetail(record)
            } else {
                // Pop to HomeVC first, then navigate
                rootViewController.popToRootViewController(animated: false)
                
                // Wait for pop to complete, then navigate
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if let homeVC = rootViewController.topViewController as? HomeVC {
                        homeVC.navigateToRecordDetail(record)
                    }
                }
            }
        }
    }
    
    private func handleNotification(userInfo: [String: AnyObject]) {
        guard let recordIDString = userInfo["recordID"] as? String else { return }
        
        print("Handling notification with recordID: \(recordIDString)")
        
        // Logic to navigate to the specific record will be handled in notification delegate methods
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    // Handle notifications when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show the notification even when the app is in foreground
        completionHandler([.banner, .sound, .badge])
    }
    
    // Handle notification interaction when user taps on it
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Get record from notification
        if let record = NotificationService.shared.getRecordFromNotificationResponse(response) {
            print("User tapped on notification for record: \(record.activityName ?? "unknown")")
            
            // Navigate to the record detail screen
            navigateToRecordDetail(record)
        } else {
            print("Could not find record for notification: \(response.notification.request.identifier)")
        }
        
        completionHandler()
    }
}

