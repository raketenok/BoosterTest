//
//  UIScheme.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 13.05.2020.
//

import Foundation
import UIKit

class UIScheme {

    static let shared = UIScheme()
    private init() {}
    
    enum Spacings {
        static let S: CGFloat = 24
        static let M: CGFloat = 44
        static let L: CGFloat = 52
    }
}
