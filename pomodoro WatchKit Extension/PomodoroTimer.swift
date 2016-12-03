//
//  PomodoroTimer.swift
//  pomodoro
//
//  Created by MacBookPro on 3/12/16.
//  Copyright © 2016 MacBookPro. All rights reserved.
//

import UIKit

class PomodoroTimer: NSObject {
    enum timerStates: Int {
        case start = 0, stop, pause
    }
    var currentState: timerstates
    
    override init() {
        currentState = timerStates.stop
    }
    //Getters
    func isInThisState(state: timerStates) -> Boolean  {
        return currentState == state
    }
    func isPlay() -> Boolean {
        isInThisState(timerstates.play)
    }
    func isStop() -> Boolean {
        isInThisState(timerstates.stop)
    }
    func isPause() -> Boolean {
        isInThisState(timerstates.pause)
    }
    
    //Setters
    func play(date:NSDate) {
        NSLog.log("play")
    }
    func pause(date:NSDate) {
        NSLog.log("pause")
    }
    func stop(date:NSDate) {
        NSLog.log("stop")
    }
}
