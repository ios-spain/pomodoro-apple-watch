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
    @IBOutlet var goupCircle: WKInterfaceGroup!
    
    var pomodoro = PomodoroTimer()
    
    //let pomodoroInSecondsTime = TimeInterval(25*60+1)
    let pomodoroInSecondsTime: TimeInterval = 15
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        pomodoro.setInterfaceTimer(timer: timer,seconds: pomodoroInSecondsTime)
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
        if pomodoro.isPlay() {
            //Lets pause
            pomodoro.pause()
            btnTimer.setText("Resume")
            
            
            // 1
            let duration = self.pomodoroInSecondsTime
            let delay = DispatchTime.now(dispatch_time_t(DISPATCH_TIME_NOW), Int64((duration + 0.15) * Double(NSEC_PER_SEC)))
            // 2
            goupCircle.setBackgroundImageNamed("Progress")
            // 3
            goupCircle.startAnimatingWithImagesInRange(NSRange(location: 0, length: 10), duration: duration, repeatCount: 1)
            // 4
            dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
                // 5
                self.flight?.checkedIn = true
                self.dismissController()
            }
            
            
            
        } else if(pomodoro.isPause()) {
            //Lets resume
            pomodoro.resume()
            btnTimer.setText("Pause")
        }else{
            //is stop
            pomodoro.play(seconds: pomodoroInSecondsTime)
            btnTimer.setText("Pause")
        }
        
    }
    @IBAction func onMenuReset() {
        pomodoro.stop()
    }

}
