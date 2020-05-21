//
//  RecordingServiceMock.swift
//  BoosterTestTests
//
//  Created by Ievgen Iefimenko on 18.05.2020.
//

import Foundation
@testable import BoosterTest

class RecordingServiceMock: NSObject, RecordingService {
  
    func continueRecording() {
        self.recordFinishCallback?(false)
    }
    
    func startRecordingSessionIfNeed() {
        self.recordFinishCallback?(false)
    }
    
    func stopRecording(removeRecord: Bool) {
        self.recordFinishCallback?(false)
    }
    
    func startRecording() {
        self.recordFinishCallback?(false)
    }
    
    func pauseRecording() {
        self.recordFinishCallback?(true)
    }
    
    var recordFinishCallback: (BoolCallback)?
    
}
