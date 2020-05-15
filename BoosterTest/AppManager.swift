//
//  AppManager.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import Foundation
import UIKit

protocol AppService: class { }

class AppManager: NSObject, UIApplicationDelegate {
  
    private var services: [AppService] = []
    static let shared = AppManager()
    
    private override init() { }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let alarmService = AlarmServiceImp()
        let timerService = TimerServiceImp()
        let recordingService = RecordingServiceImp()
        
        self.services.append(alarmService)
        self.services.append(timerService)
        self.services.append(recordingService)

        return true
    }
    
    var alarmService: AlarmService {
        return self.services.first() { nil != $0 as? AlarmService } as! AlarmService
    }
    
    var timerService: TimerService {
        return self.services.first() { nil != $0 as? TimerService } as! TimerService
    }
    
    var recordingService: RecordingService {
        return self.services.first() { nil != $0 as? RecordingService } as! RecordingService
    }
    

}
