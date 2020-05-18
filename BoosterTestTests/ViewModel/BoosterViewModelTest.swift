//
//  BoosterViewModelTest.swift
//  BoosterTestTests
//
//  Created by Ievgen Iefimenko on 18.05.2020.
//

import XCTest
@testable import BoosterTest

class BoosterViewModelTest: BoosterTestClass {

    private var viewModel: BoosterViewModel!
    
    override func setUp() {
        super.setUp()
        self.viewModel = BoosterViewModel(factory: self)
    }
    
    func test1DefaultSettings() {
        self.viewModel.timerHasBeenChanged(data: TimerData.oneMinute)
        XCTAssertTrue(self.viewModel.status == .Idle)
        XCTAssertTrue(self.viewModel.isPlaying == false)
        XCTAssertTrue(self.viewModel.timerData == .oneMinute)
        XCTAssertTrue(self.viewModel.timerRemaining == 60)
    }
    
    //MARK: Make other tests here for BoosterViewModel (Change BoosterViewModel properties and cover other public methods)
    

}
