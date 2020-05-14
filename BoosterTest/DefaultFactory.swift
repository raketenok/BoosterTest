//
//  DefaultFactory.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import Foundation

class DefaultFactory {}

//MARK: Services
extension DefaultFactory: TimerServiceFactory {}
extension DefaultFactory: AlarmServiceFactory {}
extension DefaultFactory: RecordingServiceFactory {}
