//
//  Watchdog.swift
//  Alarm Clock
//
//  Created by Falko Schumann on 26.11.18.
//  Copyright © 2018 Falko Schumann. All rights reserved.
//

import Foundation

protocol WatchdogDelegate {
    func onRemainingTime(remainingTime: TimeInterval)
    func onWakeUpTimeDiscovered()
}

class Watchdog {
    
    var delegate: WatchdogDelegate?
    
    private var watching = false
    private var wakeUpTime: Date?
    
    func startWatchingFor(wakeUpTime: Date) {
        self.wakeUpTime = wakeUpTime
        watching = true
    }
    
    func stopWatching() {
        watching = false
    }
    
    func check(currentTime: Date) {
        guard watching else {
            return
        }
        
        let remainingTime = wakeUpTime!.timeIntervalSince(currentTime)
        if remainingTime <= 0 {
            watching = false
            delegate?.onRemainingTime(remainingTime: TimeInterval(0))
            delegate?.onWakeUpTimeDiscovered()
        } else {
            delegate?.onRemainingTime(remainingTime: remainingTime)
        }
    }
    
}
