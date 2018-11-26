//
//  WatchdodTests.swift
//  Alarm ClockTests
//
//  Created by Falko Schumann on 26.11.18.
//  Copyright © 2018 Falko Schumann. All rights reserved.
//

import XCTest
@testable import Alarm_Clock

class WatchdogTests: XCTestCase {
    
    func testNothingDiscovered() {
        let sutDelegate = TestingDelegate()
        let sut = Watchdog()
        sut.delegate = sutDelegate
        let formatter = ISO8601DateFormatter()
        
        sut.startWatchingFor(wakeUpTime: formatter.date(from: "2015-01-01T10:00:00+01:00")!)
        sut.check(currentTime: formatter.date(from: "2015-01-01T09:55:35+01:00")!)
        
        XCTAssertEqual(TimeInterval(4 * 60 + 25), sutDelegate.remainingTime)
    }
    
    func testWakeUpTimeDiscovered() {
        let sutDelegate = TestingDelegate()
        let sut = Watchdog()
        sut.delegate = sutDelegate
        let formatter = ISO8601DateFormatter()
        
        sut.startWatchingFor(wakeUpTime: formatter.date(from: "2015-01-01T10:00:00+01:00")!)
        sut.check(currentTime: formatter.date(from: "2015-01-01T10:00:00+01:00")!)
        
        XCTAssertEqual(TimeInterval(0), sutDelegate.remainingTime)
        XCTAssertTrue(sutDelegate.wakeUpTimeDiscovered)
    }
    
    func testWakeUpTimeDiscoveredEvenIfAlreadyPast() {
        let sutDelegate = TestingDelegate()
        let sut = Watchdog()
        sut.delegate = sutDelegate
        let formatter = ISO8601DateFormatter()
        
        sut.startWatchingFor(wakeUpTime: formatter.date(from: "2015-01-01T10:00:00+01:00")!)
        sut.check(currentTime: formatter.date(from: "2015-01-01T10:01:10+01:00")!)
        
        XCTAssertEqual(TimeInterval(0), sutDelegate.remainingTime)
        XCTAssertTrue(sutDelegate.wakeUpTimeDiscovered)
    }
    
    func testNoMoreDiscoveriesAfterTheFirstOne() {
        let sutDelegate = TestingDelegate()
        let sut = Watchdog()
        sut.delegate = sutDelegate
        let formatter = ISO8601DateFormatter()
        
        sut.startWatchingFor(wakeUpTime: formatter.date(from: "2015-01-01T10:00:00+01:00")!)
        sut.check(currentTime: formatter.date(from: "2015-01-01T10:01:10+01:00")!)
        
        sutDelegate.remainingTime = nil
        sutDelegate.wakeUpTimeDiscovered = false
        
        sut.startWatchingFor(wakeUpTime: formatter.date(from: "2015-01-01T10:00:00+01:00")!)
        sut.check(currentTime: formatter.date(from: "2015-01-01T10:01:10+01:00")!)
        
        XCTAssertNil(sutDelegate.remainingTime)
        XCTAssertFalse(sutDelegate.wakeUpTimeDiscovered)
    }
    
}

fileprivate class TestingDelegate : WatchdogDelegate {
    
    var remainingTime: TimeInterval!
    var wakeUpTimeDiscovered = false
    
    func onRemainingTime(_ watchdog: Watchdog, remainingTime: TimeInterval) {
        self.remainingTime = remainingTime
    }
    
    func onWakeUpTimeDiscovered(_ watchdog: Watchdog) {
        wakeUpTimeDiscovered = true
    }
    
}
