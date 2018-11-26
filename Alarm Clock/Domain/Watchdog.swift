//
//  Watchdog.swift
//  Alarm Clock
//
//  Created by Falko Schumann on 26.11.18.
//  Copyright © 2018 Falko Schumann. All rights reserved.
//

import Foundation

protocol WatchdogDelegate {
    func onRemainingTime(_ watchdog: Watchdog, remainingTime: TimeInterval)
    func onWakeUpTimeDiscovered(_ watchdog: Watchdog)
}

class Watchdog {
    
    var delegate: WatchdogDelegate?
    
    func startWatchingFor(wakeUpTime: Date) {
    }
    
    func stopWatching() {
    }
    
    func check(currentTime: Date) {
    }
    
}
