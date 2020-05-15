//
//  TimerService.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import Foundation
import AVFoundation


protocol TimerServiceFactory: class {
    func makeTimeService() -> TimerService
}

extension TimerServiceFactory {
    func makeTimeService() -> TimerService {
        return AppManager.shared.timerService
    }
}

protocol TimerService: AppService {
    func playSounds(seconds: Int)
    func stopSounds()
    var timerRemaining: Double? { get }
    var recordCallback: (EmptyCallback)? { get set }
}

class TimerServiceImp: TimerService {
 
    typealias Factory = DefaultFactory
    private var timer = Timer()
    private var player: AVAudioPlayer?

    init(factory: Factory = DefaultFactory()) {
        
    }
    
    //MARK: TimerService
    var timerRemaining: Double?
    var recordCallback: (EmptyCallback)?
    
    func playSounds(seconds: Int) {
        self.play()
        self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(seconds), repeats: false) { (t) in
            self.stopSounds()
            self.recordCallback?()
        }
    }
    
    func stopSounds() {
        guard let player = self.player else { return }
        player.pause()
        self.timerRemaining = timer.fireDate.timeIntervalSince(Date())
        self.timer.invalidate()
    }
    
    //MARK: Private
    private func play() {
        guard let url = Bundle.main.url(forResource: "nature", withExtension: "m4a") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.m4a.rawValue)
            
            guard let player = self.player else { return }
            player.numberOfLoops = -1
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
