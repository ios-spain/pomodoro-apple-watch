//
//  PomodoroTimer.swift
//  pomodoro
//
//  Created by MacBookPro on 3/12/16.
//  Copyright © 2016 MacBookPro. All rights reserved.
//

import WatchKit
import Foundation

class PomodoroTimer: NSObject {
    enum timerStates: Int {
        case play = 0, stop, pause
    }
    var currentState: timerStates
    var timer: WKInterfaceTimer!
    var realTimer = Timer()
    var startTime = Date()
    var elapsedTime = 0.0
    var duration = 0.0
    
    override init() {
        currentState = timerStates.stop
    }
    //Getters
    func isInThisState(state: timerStates) -> Bool  {
        return currentState == state
    }
    func isPlay() -> Bool {
        return isInThisState(state: timerStates.play)
    }
    func isStop() -> Bool {
        return isInThisState(state: timerStates.stop)
    }
    func isPause() -> Bool {
        return isInThisState(state: timerStates.pause)
    }
    
    //Setters
    func setInterfaceTimer(timer: WKInterfaceTimer, seconds: Double) {
        self.timer = timer
        self.timer.setDate(Date(timeIntervalSinceNow: seconds))
        duration = seconds
    }
    func play(seconds:Double) {
        print("play")
        self.timer.setDate(Date(timeIntervalSinceNow: seconds))
        duration = seconds
        elapsedTime = 0
        self.timer.start()
        self.currentState = timerStates.play
        startTime = Date()
    }
    func pause() {
        print("pause")
        self.timer.stop()
        self.currentState = timerStates.pause
        startTime = Date()
    }
    func resume() {
        print("resume")
        elapsedTime += Date().timeIntervalSince(startTime)
        self.timer.setDate(Date(timeIntervalSinceNow: duration-elapsedTime))
        self.timer.start()
        self.currentState = timerStates.play
    }
    func stop() {
        print("stop")
        self.timer.stop()
        self.currentState = timerStates.stop
    }
}
