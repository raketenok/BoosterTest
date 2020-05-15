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
    
    typealias Factory = DefaultFactory
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder?
    
    init(factory: Factory = DefaultFactory()) {
        
    }
    
    //MARK: RecordingService
    var finishedRecording: (BoolCallback)?

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
            self.recordingSession.requestRecordPermission { (isAllow) in
           
                guard isAllow else {
                    self.finishedRecording?(false)
                    return
                }
                self.record()
            }
        } catch {
            print(error)
            self.finishedRecording?(false)
        }
    }
    
    //MARK: Private
    private func record() {
        
        guard let directory = self.getDocumentsDirectory() else { return }
        
        let audioFilename = directory.appendingPathComponent("\(Date()).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
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
    
    private func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }
}

extension RecordingServiceImp: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        self.finishedRecording?(flag)
    }
    
}
 
