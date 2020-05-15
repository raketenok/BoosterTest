//
//  BoosterViewModel.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 13.05.2020.
//

import Foundation
import AVFoundation

enum StatusType: String {
    case Idle
    case Recording
    case Playing
    case Alarm
    case Paused
}

enum TimerData: Int, CaseIterable {
    case off = 0
    case oneMinute = 1
    case fiveMinutes = 5
    case tenMinutes = 10
    case fifteenMinutes = 15
    case twentyMinutes = 20
}

class BoosterViewModel: ObservableObject {
    
    typealias Factory = TimerServiceFactory & AlarmServiceFactory & RecordingServiceFactory
    
    @Published private(set) var timerData = TimerData.off
    @Published private(set) var status: StatusType = .Idle
    @Published private(set) var isPlaying: Bool = false
    @Published var isRecordingError: Bool = false

    private var timer = Timer()
    private let timerService: TimerService!
    private let alarmService: AlarmService!
    private let recordingService: RecordingService!
    private var timerFinished = false
    private var timerRemaining: Int = 0
    
    init(factory: Factory = DefaultFactory()) {
        self.timerService = factory.makeTimeService()
        self.alarmService = factory.makeAlarmService()
        self.recordingService = factory.makeRecordingService()
        self.timerService.recordCallback = { [weak self] in
            //start recording
            self?.timerRemaining = 0
            self?.timerFinished = true
            self?.timerData = .off
            self?.status = .Recording
            self?.recordingService.startRecording()
        }
        self.recordingService.finishedRecording = { [weak self] success in
            self?.status = .Idle
            self?.isPlaying = false
            self?.isRecordingError = !success
        }
    }
    
    func statusTitleText(status: StatusType) -> String {
        return status.rawValue
    }
    
    func updateStatus() {
        
        self.isPlaying.toggle()
        self.status = StatusType.Idle
        
        if self.isPlaying {
            if self.timerData != .off {
                //Timer is running
                //Play sounds with timer
                self.status = .Playing
                self.timerService.playSounds(seconds: self.timerRemaining)
            } else {
                //Timer isn't running
                //Immediately start recording if timer is off
                self.status = .Recording
                self.recordingService.startRecording()
            }

        } else {
            self.status = .Paused

            if self.timerData == .off {
                //Timer isn't running
                //Stop recording
                //Use pauseRecording() if timer has already finished , use stopRecording() if timer hasn't started yet
                if self.timerFinished {
                    self.recordingService.pauseRecording()
                } else {
                    self.recordingService.stopRecording()
                    self.status = .Idle
                }
            }
            self.timerService.stopSounds()
            guard let remainig = self.timerService.timerRemaining else { return }
            self.timerRemaining = Int(remainig)
        }
    }
    
    func timerHasBeenChanged(data: TimerData) {
        //Stop all services, excl. AlarmService
        self.isPlaying = false
        self.status = .Idle
        self.timerService.stopSounds()
        self.recordingService.stopRecording()
        self.timerData = data
        self.timerRemaining = self.timerData.rawValue * 60
    }
}

