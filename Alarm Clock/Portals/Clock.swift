//
//  Clock.swift
//  Alarm Clock
//
//  Created by Falko Schumann on 27.11.18.
//  Copyright © 2018 Falko Schumann. All rights reserved.
//

import Foundation

protocol ClockDelegate {
    func onCurrentTime(_ clock: Clock, currentTime: Date)
}

class Clock {
    
    var delegate: ClockDelegate?
    
    private var timer: Timer!
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.delegate?.onCurrentTime(self, currentTime: Date())
        }
    }
    
    deinit {
        timer.invalidate()
    }
    
}
