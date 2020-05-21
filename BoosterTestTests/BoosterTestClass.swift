//
//  BoosterTest.swift
//  BoosterTestTests
//
//  Created by Ievgen Iefimenko on 18.05.2020.
//

import XCTest


@testable import BoosterTest

class BoosterTestClass: XCTestCase,
                        PlayerServiceFactory,
                        AlarmServiceFactory,
                        RecordingServiceFactory,
                        NotificationServiceFactory
                        {


    private(set) var alarmService: AlarmServiceMock!
    private(set) var recordingService: RecordingServiceMock!
    private(set) var playerService: PlayerServiceMock!
    private(set) var notificationService: NotificationServiceMock!
    
    override func setUp() {
        self.alarmService = AlarmServiceMock()
        self.recordingService = RecordingServiceMock()
        self.playerService = PlayerServiceMock()
        self.notificationService = NotificationServiceMock()

    }
    
    func makeAlarmService() -> AlarmService {
        return self.alarmService
    }
    
    func makePlayerService() -> PlayerService {
        return self.playerService
    }
    
    func makeRecordingService() -> RecordingService {
        return self.recordingService
    }
    
    func makeNotificationService() -> NotificationService {
        return self.notificationService
    }

}
