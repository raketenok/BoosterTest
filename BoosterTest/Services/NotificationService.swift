//
//  NotificationService.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 17.05.2020.
//

import Foundation
import NotificationCenter

protocol NotificationServiceFactory: class {
    func makeNotificationService() -> NotificationService
}

extension NotificationServiceFactory {
    
    func makeNotificationService() -> NotificationService {
        return AppManager.shared.notificationService
    }
}

protocol NotificationService: AppService {
    func scheduleNotification(at date: Date)
}

class NotificationServiceImp: NSObject, NotificationService {
    
    typealias Factory = DefaultFactory
    let notificationCenter = UNUserNotificationCenter.current()
    
    init(factory: Factory = DefaultFactory()) {
        
    }
        
    func scheduleNotification(at date: Date) {
        self.notificationCenter.removeAllPendingNotificationRequests()
        
        let id = UUID().uuidString
        let content = UNMutableNotificationContent()
        content.title = "Wake up!"
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        self.notificationCenter.add(request) { error in
             guard error == nil else { return }
            print("Scheduling notification with id: \(id)")
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        return true
    }
}


extension NotificationServiceImp: UNUserNotificationCenterDelegate {
  
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if UIApplication.shared.applicationState != .active {
            completionHandler()
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if UIApplication.shared.applicationState == .active {
            completionHandler([])
        } else {
            completionHandler([.alert, .sound])
        }
    }
}

