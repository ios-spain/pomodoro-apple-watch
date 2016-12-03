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
    @IBOutlet var groupCircle: WKInterfaceGroup!
    
    var pomodoro = PomodoroTimer()
    var background = PomodoroInterfaceGroup()
    
    //let pomodoroInSecondsTime = TimeInterval(25*60+1)
    let pomodoroInSecondsTime: TimeInterval = 15
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        //groupCircle.setHeight(groupCircle.frame.size.width) //make it square, i don't know how to get the width
        // Configure interface objects here.
        pomodoro.setInterfaceTimer(timer: timer,seconds: pomodoroInSecondsTime)
        background.setGroup(group: groupCircle, totalFrames: 100, imageNameRoot: "circle-")
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
            
        } else if(pomodoro.isPause()) {
            //Lets resume
            pomodoro.resume()
            btnTimer.setText("Pause")
        }else{
            //is stop
            pomodoro.play(seconds: pomodoroInSecondsTime)
            btnTimer.setText("Pause")
            //Fast animation
            background.startFastAnimationWithCompletion {
                print ("end animation")
                self.background.setFrame(frame: 0)
            }
        }
    }
    @IBAction func onMenuReset() {
        pomodoro.stop()
    }

}
