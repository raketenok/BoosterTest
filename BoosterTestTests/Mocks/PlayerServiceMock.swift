//
//  PlayerServiceMock.swift
//  BoosterTestTests
//
//  Created by Ievgen Iefimenko on 18.05.2020.
//

import Foundation

@testable import BoosterTest

class PlayerServiceMock: NSObject, PlayerService {
    
    func playSounds(seconds: Int, trackName: String) {
        self.finishedByStop?(false)
    }
    
    func playSoundsInfinitely(trackName: String) {
        
    }
    
    func pauseSounds() {
        self.finishedByStop?(false)
    }
    
    func stopSounds() {
        self.finishedByStop?(true)
    }
    
    var timerRemaining: Double?
    var finishedByStop: (BoolCallback)?
    
}
