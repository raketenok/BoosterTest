//
//  DefaultFactory.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import Foundation

class DefaultFactory {}

//MARK: Services
extension DefaultFactory: PlayerServiceFactory {}
extension DefaultFactory: AlarmServiceFactory {}
extension DefaultFactory: RecordingServiceFactory {}
extension DefaultFactory: NotificationServiceFactory {}
