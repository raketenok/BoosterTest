//
//  BoosterViewModel.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 13.05.2020.
//

import Foundation

class BoosterViewModel {
    
    
    func playTitleText(isPlaying: Bool) -> String {
        return isPlaying ? "Playing" : "Stopped"
    }
    
    func playAction(isPlaying: Bool) {
        //TODO: PLAY CATION
        print(isPlaying)
    }
}
