//
//  InterfaceController.swift
//  pomodoro WatchKit Extension
//
//  Created by MacBookPro on 28/11/16.
//  Copyright © 2016 MacBookPro. All rights reserved.
//

import WatchKit
import Foundation
//import PomodoroTimer


class PomodoroController: WKInterfaceController {
    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet var btnTimer: WKInterfaceLabel!
    
    
    var pomodoro = PomodoroTimer()
    
    //let pomodoroInSecondsTime = TimeInterval(25*60+1)
    let pomodoroInSecondsTime: TimeInterval = 5
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        timer.setDate(Date(timeIntervalSinceNow: pomodoroInSecondsTime))
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func onTimerButton() {
        // 1
        if timerRunning {
            timer.stop()
            btnTimer.setText("Start")
            
        } else {
            // 2
            if timerEnded {
                timerEnded = false
                timer.setDate(Date(timeIntervalSinceNow: pomodoroInSecondsTime))
            }
            timer.start()
            btnTimer.setText("Pause")
        }
        // 3
        timerRunning = !timerRunning
        
    }

}
