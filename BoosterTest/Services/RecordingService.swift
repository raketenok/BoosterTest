//
//  RecordingService.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import Foundation
import AVFoundation

protocol RecordingServiceFactory: class {
    func makeRecordingService() -> RecordingService
}

extension RecordingServiceFactory {
    func makeRecordingService() -> RecordingService {
        return AppManager.shared.recordingService
    }
}

protocol RecordingService: AppService {
    
    func startRecording()
    func stopRecording()
    func pauseRecording()
    
    var finishedRecording: (BoolCallback)? { get set }
}

class RecordingServiceImp: NSObject, RecordingService {
    
    var finishedRecording: (BoolCallback)?
    typealias Factory = DefaultFactory
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder?
    
    
    init(factory: Factory = DefaultFactory()) {
        
    }
    
    func pauseRecording() {
        self.audioRecorder?.pause()
    }
    
    func stopRecording() {
        self.audioRecorder?.stop()
    }
    
    func startRecording() {
        do {
            self.recordingSession = AVAudioSession.sharedInstance()
            try self.recordingSession.setCategory(.playAndRecord, mode: .default)
            try self.recordingSession.setActive(true)
        } catch {
            print(error)
            self.finishedRecording?(false)
        }
        
        let audioFilename = self.getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatAppleIMA4),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            self.audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            guard let audioRecorder = self.audioRecorder else { return }
            
            audioRecorder.delegate = self
            audioRecorder.record()

        } catch {
            print(error)
            self.finishedRecording?(false)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension RecordingServiceImp: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            self.finishedRecording?(true)
        }
    }
    
}
 
