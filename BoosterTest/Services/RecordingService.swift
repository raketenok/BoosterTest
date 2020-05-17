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
    var recordFinishCallback: (BoolCallback)? { get set }
}

class RecordingServiceImp: NSObject, RecordingService {
    
    typealias Factory = DefaultFactory
    private var audioRecorder: AVAudioRecorder?
    
    init(factory: Factory = DefaultFactory()) {
    }
    
    //MARK: RecordingService
    var recordFinishCallback: (BoolCallback)?

    func pauseRecording() {
        self.audioRecorder?.pause()
    }
    
    func stopRecording() {
        self.audioRecorder?.stop()
    }
    
    func startRecording() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            AVAudioSession.sharedInstance().requestRecordPermission { (isAllow) in
           
                guard isAllow else {
                    self.recordFinishCallback?(false)
                    return
                }
                self.record()
            }
        } catch {
            self.recordFinishCallback?(false)
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
            self.recordFinishCallback?(false)
        }
    }
    
    private func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }
    
}

extension RecordingServiceImp: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        self.recordFinishCallback?(flag)
    }
    
}
 
