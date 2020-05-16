//
//  AlarmService.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import Foundation

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
    
}

class AlarmServiceImp: AlarmService {
    var alarmCallback: (EmptyCallback)?
    
   
    
    typealias Factory = DefaultFactory
    private var timer = Timer()

    
    init(factory: Factory = DefaultFactory()) {
        
        
        
    }
    
    func startAlarm(date: Date) {
           
    }
}
