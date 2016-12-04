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
    var pomodoroInSecondsTime: TimeInterval = 15
    
    enum pomodoroStates: Double {
        case work = 25, restPause = 5, longRestPause = 15
    }
    let labelsStates = [
        pomodoroStates.work: "Start",
        pomodoroStates.restPause: "Rest",
        pomodoroStates.longRestPause: "Long Rest",
    ]
    var currentState: pomodoroStates = pomodoroStates.work
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        //groupCircle.setHeight(groupCircle.frame.size.width) //make it square, i don't know how to get the width
        // Configure interface objects here.
        pomodoro.setInterfaceTimer(timer: timer,seconds: pomodoroInSecondsTime, completionStopHandler: self.onTimerFinish)
        background.setGroup(group: groupCircle, totalFrames: 100, imageNameRoot: "circle-")
        
        background.startFastAnimationWithCompletion {
            print ("end animation in startup")
        }
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
            let elapsedTime = pomodoro.pause()
            print("elapsedTime \(elapsedTime)")
            btnTimer.setText("Resume")
            background.stopAnimating()
            background.setFramePercentage(p:(elapsedTime*100/pomodoroInSecondsTime))
        } else if(pomodoro.isPause()) {
            //Lets resume
            pomodoro.resume()
            btnTimer.setText("Pause")
            let elapsedTime = pomodoro.getElapsedTime()
            let percentageElapsedTime = elapsedTime*100/pomodoroInSecondsTime
            self.background.startAnimationPercentageProgress(frameFromPercent: percentageElapsedTime, frameToPercent: 100, duration: (pomodoroInSecondsTime - elapsedTime))
        }else{
            //is stop so lets play/start
            pomodoro.play(seconds: pomodoroInSecondsTime)
            btnTimer.setText("Pause")
            //Fast animation
            background.startFastAnimationWithCompletion {
                print ("end animation")
                self.background.startAnimationPercentageProgress(frameFromPercent: 0, frameToPercent: 100, duration: self.pomodoroInSecondsTime-1)
            }
        }
    }
    @IBAction func onMenuReset() {
        pomodoro.stop()
        changeState(futureState: pomodoroStates.work)
    }
    
    func changeState(futureState: pomodoroStates) {
        currentState = futureState
        pomodoroInSecondsTime = futureState.rawValue
        pomodoro.initTimer(seconds: futureState.rawValue)
        self.btnTimer.setText(labelsStates[futureState])
    }
    
    func onTimerFinish(){
        print("RING CONTROLER")
        if pomodoroStates.work == currentState {
            changeState(futureState: pomodoroStates.restPause)
            //TODO: Send it to backend. One pomodoro finished
        }else{
            changeState(futureState: pomodoroStates.work)
        }
    }

}
