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
    func playSounds(minutes: Int)
    func stopSounds()
    var recordCallback: (EmptyCallback)? { get set }
}

class TimerServiceImp: TimerService {
   
    var recordCallback: (EmptyCallback)?
    typealias Factory = DefaultFactory
    private var timer = Timer()
    private var player: AVAudioPlayer?

    init(factory: Factory = DefaultFactory()) {
        
    }
    
    func playSounds(minutes: Int) {
        self.play()
        let minutes: Double = Double(minutes) * 60
        self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(minutes), repeats: false) { (t) in
            self.stopSounds()
            self.recordCallback?()
        }
    }
    
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
    
        
    func stopSounds() {
        guard let player = self.player else { return }
        player.pause()
        self.timer.invalidate()
    }

}
