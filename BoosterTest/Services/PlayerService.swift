//
//  TimerService.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import Foundation
import AVFoundation


protocol PlayerServiceFactory: class {
    func makePlayerService() -> PlayerService
}

extension PlayerServiceFactory {
    func makePlayerService() -> PlayerService {
        return AppManager.shared.playerService
    }
}

protocol PlayerService: AppService {
    func playSounds(seconds: Int, trackName: String)
    func playSoundsInfinitely(trackName: String)
    func pauseSounds()
    func stopSounds()
    var timerRemaining: Double? { get }
    var finishedByStop: (BoolCallback)? { get set }
}

class PlayerServiceImp: NSObject, PlayerService {
    
    typealias Factory = DefaultFactory
    private var timer = Timer()
    private var player: AVAudioPlayer?
    private let theSession = AVAudioSession.sharedInstance()

    init(factory: Factory = DefaultFactory()) {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption(notification:)), name: AVAudioSession.interruptionNotification, object: nil)
    }
    
    //MARK: TimerService
    var timerRemaining: Double?
    var finishedByStop: (BoolCallback)?
    
    func playSounds(seconds: Int, trackName: String) {
        self.play(trackName: trackName)

        self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(seconds), repeats: false) { (t) in
            self.pauseSounds()
            self.finishedByStop?(false)
        }
    }
    
    func playSoundsInfinitely(trackName: String) {
        self.play(trackName: trackName)
    }
    
    func pauseSounds() {
        if self.timer.isValid {
            self.timerRemaining = self.timer.fireDate.timeIntervalSince(Date())
        }
        self.stop()
    }
    
    func stopSounds() {
        self.stop()
        self.timerRemaining = 0
        self.finishedByStop?(true)
    }    
    
    //MARK: Private
    private func stop() {
        self.player?.stop()
        self.timer.invalidate()
    }
    
    private func play(trackName: String) {
        guard let url = Bundle.main.url(forResource: trackName, withExtension: "m4a") else { return }

        do {
            try self.theSession.setCategory(.playback, options: .mixWithOthers)

            try self.theSession.setActive(true)

            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.m4a.rawValue)
            
            guard let player = self.player else { return }
            player.numberOfLoops = -1
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc private func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
                return
        }

        // Switch over the interruption type.
        switch type {
        case .began:
            self.player?.stop()
        case .ended:
            guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
            let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
            if options.contains(.shouldResume) {
                try? self.theSession.setActive(true)
                if self.timer.isValid {
                    self.player?.play()
                }
            }
        default: ()
        }
    }
}
