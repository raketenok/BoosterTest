//
//  RecordingService.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import Foundation
import AVFoundation
import UIKit

protocol RecordingServiceFactory: class {
    func makeRecordingService() -> RecordingService
}

extension RecordingServiceFactory {
    func makeRecordingService() -> RecordingService {
        return AppManager.shared.recordingService
    }
}

protocol RecordingService: AppService {
    func continueRecording()
    func startRecordingSessionIfNeed()
    func startRecording()
    func stopRecording(removeRecord: Bool)
    func pauseRecording()
    var recordFinishCallback: (BoolCallback)? { get set }
}

class RecordingServiceImp: NSObject, RecordingService {
   
    
    
    typealias Factory = DefaultFactory
    private var audioRecorder: AVAudioRecorder?
    private let theSession = AVAudioSession.sharedInstance()
    private var isActive = false
    private var trackName: String! = ""
    
    init(factory: Factory = DefaultFactory()) {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption(notification:)), name: AVAudioSession.interruptionNotification, object: nil)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.requestRecordingPermission(result: { success in })
        return true
    }
    
    //MARK: RecordingService
    var recordFinishCallback: (BoolCallback)?
    
    func pauseRecording() {
        self.audioRecorder?.pause()
    }
    
    func stopRecording(removeRecord: Bool) {
        self.trackName = ""
        self.audioRecorder?.stop()
        if removeRecord {
           self.audioRecorder?.deleteRecording()
        }
        self.isActive = false
    }
    
    func continueRecording() {
        guard self.isActive else { return }
        self.audioRecorder?.record()
    }
    
    func startRecordingSessionIfNeed() {
        
        guard !self.isActive else { return }
        //Run for first time
        do {
            try self.theSession.setCategory(.playAndRecord, options: .mixWithOthers)
            
            try self.theSession.setActive(true)
            self.requestRecordingPermission { success in
                
                guard success else {
                    self.recordFinishCallback?(false)
                    return
                }
                //Set trackName and start recording immediately
                self.trackName = "\(Date())"
                self.record(trackName: self.trackName)
            }
        } catch {
            self.recordFinishCallback?(false)
        }
    }
    
    func startRecording() {
        //Rewrite audio file with current trackName
        self.record(trackName: self.trackName)
    }
    
    //MARK: Private
    private func record(trackName: String) {
        
        guard let directory = self.getDocumentsDirectory() else { return }

        let audioFilename = directory.appendingPathComponent("\(trackName).m4a")
        
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
            self.isActive = true

        } catch {
            self.recordFinishCallback?(false)
        }
    }
    
    private func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }
    
    private func requestRecordingPermission(result: @escaping BoolCallback) {
        self.theSession.requestRecordPermission { (isAllow) in
             result(isAllow)
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
             if self.isActive {
                self.audioRecorder?.pause()
            }
         case .ended:
             guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
             let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
             if options.contains(.shouldResume) {
                 if self.isActive {
                    self.audioRecorder?.record()
                 }
             }
         default: ()
         }
     }
    
}

extension RecordingServiceImp: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        self.recordFinishCallback?(flag)
    }
    
}
 
