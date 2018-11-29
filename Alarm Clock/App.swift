//
//  App.swift
//  Alarm Clock
//
//  Created by Falko Schumann on 29.11.18.
//  Copyright © 2018 Falko Schumann. All rights reserved.
//

import Foundation

class App: ClockDelegate{
    
    static let shared = App()
    
    let watchdog = Watchdog()
    let clock = Clock()
    var alarmClockDialog: AlarmClockDialogController?
    let alarmBell = AlarmBell()
    
    init() {
        clock.delegate = self
    }
    
    func onCurrentTime(currentTime: Date) {
        watchdog.check(currentTime: currentTime)
        alarmClockDialog?.updateCurrentTime(currentTime)
    }

}

extension Watchdog: AlarmClockDialogDelegate {
    
    func onStartRequested(wakeUpTime: Date) {
        startWatchingFor(wakeUpTime: wakeUpTime)
    }
    
    func onStopRequested() {
        stopWatching()
    }
    
}

extension AlarmClockDialogController: WatchdogDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        App.shared.alarmClockDialog = self
        App.shared.watchdog.delegate = self
        delegate = App.shared.watchdog
    }
    
    func onRemainingTime(remainingTime: TimeInterval) {
        updateRemainingTime(remainingTime)
    }
    
    func onWakeUpTimeDiscovered() {
        wakeUpTimeReached()
        App.shared.alarmBell.ring()
    }
    
}
