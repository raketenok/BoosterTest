//
//  AlarmServiceMock.swift
//  BoosterTestTests
//
//  Created by Ievgen Iefimenko on 18.05.2020.
//

import Foundation
@testable import BoosterTest

class AlarmServiceMock: NSObject, AlarmService {
    var alarmCallback: (EmptyCallback)?
    
    func startAlarm(date: Date) {
        
    }
    
    func stopAlarm() {
        
    }
}
