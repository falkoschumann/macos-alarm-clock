//
//  AlarmClockDialogController.swift
//  Alarm Clock
//
//  Created by Falko Schumann on 29.11.18.
//  Copyright © 2018 Falko Schumann. All rights reserved.
//

import Cocoa

protocol AlarmClockDialogDelegate {
    func onStartRequested(wakeUpTime: Date)
    func onStopRequested()
}

class AlarmClockDialogController: NSViewController {
    
    var delegate: AlarmClockDialogDelegate?
    
    @IBOutlet weak var currentTimeLabel: NSTextField!
    @IBOutlet weak var remainingTimeLabel: NSTextField!
    @IBOutlet weak var wakeUpTimeTextField: NSTextField!
    @IBOutlet weak var startStopButton: NSButton!
    
    @IBAction func startStopButtonClicked(_ sender: NSButton) {
        if sender.state == .on {
            if remainingTimeLabel.isHidden {
                remainingTimeLabel.isHidden = false
                remainingTimeLabel.stringValue = ""
                
                let formatter = DateFormatter()
                formatter.dateStyle = .none
                formatter.timeStyle = .medium
                delegate?.onStartRequested(wakeUpTime: formatter.date(from: wakeUpTimeTextField.stringValue)!)
            }
        } else {
            remainingTimeLabel.isHidden = true
            delegate?.onStopRequested()
        }
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        
        delegate?.onStopRequested()
    }
    
    func updateCurrentTime(_ time: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .long
        currentTimeLabel.stringValue = formatter.string(from: time)
    }
    
    func updateRemainingTime(_ time: TimeInterval) {
        let t = Date(timeIntervalSinceReferenceDate: time)
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .long
        formatter.timeZone = TimeZone(identifier: "UTC")
        remainingTimeLabel.stringValue = formatter.string(from: t)
    }
    
    func wakeUpTimeReached() {
        remainingTimeLabel.isHidden = true
        startStopButton.state = .off
    }
    
}
