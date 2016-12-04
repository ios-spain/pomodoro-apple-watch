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
    var currentState: timerStates = timerStates.stop
    var timer: WKInterfaceTimer!
    var realTimer = Timer()
    var startTime = Date()
    var elapsedTime = 0.0
    var duration = 0.0
    
    var stopHandler: () -> Void = {()}
    
    override init() {
        super.init()
        //currentState = timerStates.stop
        //Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(countDownDone), userInfo: nil, repeats: false)
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
    func getElapsedTime() -> Double{
        return elapsedTime
    }
    
    //Setters
    //WKInterfaceTimer
    func setInterfaceTimer(timer: WKInterfaceTimer, seconds: Double, completionStopHandler: @escaping () -> Void) {
        self.timer = timer
        initTimer(seconds: seconds)
        self.stopHandler = completionStopHandler
    }
    func initTimer(seconds:Double) {
        self.timer.setDate(Date(timeIntervalSinceNow: seconds))
        duration = seconds
        elapsedTime = 0
    }
    //realTimer
    func stopRealTimer() {
        self.realTimer.invalidate()
    }
    func stopAndThenStartRealTimer(seconds:Double){
        self.stopRealTimer()
        self.realTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(countDownDone), userInfo: nil, repeats: false)
    }
    //Common functions
    func play(seconds:Double) {
        print("play")
        startTime = Date()
        initTimer(seconds: seconds)
        self.timer.start()
        self.currentState = timerStates.play
        stopAndThenStartRealTimer(seconds: seconds)
    }
    func pause() -> Double {
        print("pause")
        elapsedTime += Date().timeIntervalSince(startTime)
        self.timer.stop()
        self.stopRealTimer()
        self.currentState = timerStates.pause
        return elapsedTime
    }
    func resume() {
        print("resume")
        startTime = Date()
        stopAndThenStartRealTimer(seconds: duration-elapsedTime)
        self.timer.setDate(Date(timeIntervalSinceNow: (duration-elapsedTime) ))
        self.timer.start()
        self.currentState = timerStates.play
    }
    func stop() {
        //Called from menu reset
        print("stop")
        self.timer.stop()
        stopRealTimer()
        self.currentState = timerStates.stop
        //Init WKInterfaceTimer with the last duration used
        initTimer(seconds: duration)
    }
    
    //RING RING 
    func countDownDone() {
        //Automatically stopped in the final countdown
        print("RING RING !! \(elapsedTime)")
        self.stop()
        WKInterfaceDevice.current().play(.click)
        self.stopHandler()
    }
}
