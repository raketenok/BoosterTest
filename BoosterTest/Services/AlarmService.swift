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
    
}

class AlarmServiceImp: AlarmService {
    typealias Factory = DefaultFactory

    init(factory: Factory = DefaultFactory()) {
        
        
        
    }
}
