//
//  AppManager.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import Foundation
import UIKit

protocol AppService: NSObject, UIApplicationDelegate { }

class AppManager {
  
    private var services: [AppService] = []
    static let shared = AppManager()
    
    private init() { }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let notificationService = NotificationServiceImp()
        self.services.append(notificationService)

        let alarmService = AlarmServiceImp()
        self.services.append(alarmService)
      
        let playerService = PlayerServiceImp()
        self.services.append(playerService)

        let recordingService = RecordingServiceImp()
        self.services.append(recordingService)

        self.services.forEach() { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }
    
    var alarmService: AlarmService {
        return self.services.first() { nil != $0 as? AlarmService } as! AlarmService
    }
    
    var playerService: PlayerService {
        return self.services.first() { nil != $0 as? PlayerService } as! PlayerService
    }
    
    var recordingService: RecordingService {
        return self.services.first() { nil != $0 as? RecordingService } as! RecordingService
    }
    
    var notificationService: NotificationService {
        return self.services.first() { nil != $0 as? NotificationService } as! NotificationService
    }
    

}
