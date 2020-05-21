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

enum ActiveAlert {
    case recording, alarm
}

class BoosterViewModel: ObservableObject {
    
    typealias Factory = PlayerServiceFactory & AlarmServiceFactory & RecordingServiceFactory
    
    @Published private(set) var timerData = TimerData.off
    @Published private(set) var status: StatusType = .Idle
    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var alarmDate: Date?

    @Published var showAlert: Bool = false
    @Published var isDatePickerShowed: Bool = false

    private(set) var activeAlert: ActiveAlert = .alarm
    private(set) var timerRemaining: Int = 0
    private let playerService: PlayerService!
    private let alarmService: AlarmService!
    private let recordingService: RecordingService!
    
    init(factory: Factory = DefaultFactory()) {
        
        self.playerService = factory.makePlayerService()
        self.alarmService = factory.makeAlarmService()
        self.recordingService = factory.makeRecordingService()
        self.playerService.finishedByStop = { [weak self] byStop in
            //start recording
            self?.timerRemaining = 0
            self?.timerData = .off
            
            guard !byStop else {
                return
            }
            self?.status = .Recording
            self?.recordingService.startRecording()
        }
        
        self.recordingService.recordFinishCallback = { [weak self] success in
            guard !success else { return }
            self?.status = .Idle
            self?.activeAlert = .recording
            self?.showAlert = true
        }
        
        self.alarmService.alarmCallback = { [weak self] in
            self?.stopSoundsAndRecording()
            self?.playerService.playSoundsInfinitely(trackName: UIScheme.ConstantsLabels.alarmTrack)
            self?.activeAlert = .alarm
            self?.showAlert = true
            self?.alarmDate = nil
            self?.status = .Idle
            self?.isPlaying = false
        }

    }
    
    func statusTitleText(status: StatusType) -> String {
        return status.rawValue
    }

    func updateAlarm(date: Date) {
        let dateNow = Date().minAlarmDate()
        let selectedDate = dateNow.isDescendingThan(date) ? dateNow : date
        self.alarmDate = selectedDate
        self.alarmService.startAlarm(date: selectedDate)
    }
    
    func stopAlarmSounds() {
        self.playerService.stopSounds()
    }
    
    func updatePlayingStatus() {
        
        self.isPlaying.toggle()
        self.status = StatusType.Idle
        
        if self.isPlaying {
            if self.timerData != .off {
                //Timer is running
                //Play sounds with timer
                self.status = .Playing
                self.playerService.playSounds(seconds: self.timerRemaining, trackName: UIScheme.ConstantsLabels.natureTrack)
            } else {
                //Timer isn't running
                //Immediately start recording if timer is off
                self.status = .Recording
                self.recordingService.continueRecording()
            }
            self.recordingService.startRecordingSessionIfNeed()

        } else {
            self.status = .Paused
            if self.timerData == .off {
                //Timer isn't running
                //Stop recording
                self.recordingService.pauseRecording()
            }
            self.playerService.pauseSounds()
            guard let remainig = self.playerService.timerRemaining else { return }
            self.timerRemaining = Int(remainig)
        }
    }
    
    func timerHasBeenChanged(data: TimerData) {
        //Stop all services, excl. AlarmService
        self.status = .Idle
        self.isPlaying = false
        self.stopSoundsAndRecording()
        self.timerData = data
        self.timerRemaining = self.timerData.rawValue * 5
    }
    
    //MARK: Private
    private func stopSoundsAndRecording() {
        self.recordingService.stopRecording(removeRecord: self.timerRemaining > 0)
        self.playerService.stopSounds()
    }
}
