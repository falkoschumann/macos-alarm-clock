//
//  AlarmBell.swift
//  Alarm Clock
//
//  Created by Falko Schumann on 28.11.18.
//  Copyright © 2018 Falko Schumann. All rights reserved.
//

import Foundation
import AppKit

class AlarmBell {
    
    func ring() {
        let url = Bundle.main.url(forResource: "Alarm", withExtension: "mp3")
        let alarm = NSSound(contentsOf: url!, byReference: false)
        alarm!.play()
    }
    
}
