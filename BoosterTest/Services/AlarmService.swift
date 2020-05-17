//
//  AlarmService.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import Foundation
import NotificationCenter

protocol AlarmServiceFactory: class {
    func makeAlarmService() -> AlarmService
}

extension AlarmServiceFactory {
    func makeAlarmService() -> AlarmService {
        return AppManager.shared.alarmService
    }
}

protocol AlarmService: AppService {
 
    var alarmCallback: (EmptyCallback)? { get set }
    func startAlarm(date: Date)
    func stopAlarm()
}

class AlarmServiceImp: NSObject, AlarmService {
 
    typealias Factory = NotificationServiceFactory
    private var timer = Timer()
    private let notificationService: NotificationService!
    
    init(factory: Factory = DefaultFactory()) {
        self.notificationService = factory.makeNotificationService()
    }
    
    //MARK: AlarmService
    var alarmCallback: (EmptyCallback)?

    func startAlarm(date: Date) {
        self.timer.invalidate()
        let interval = date.timeIntervalSince(Date())
        self.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { (t) in
            self.alarmCallback?()
        }
        self.notificationService.scheduleNotification(at: date)
    }
    
    func stopAlarm() {
        self.timer.invalidate()
        self.alarmCallback?()
    }

}
