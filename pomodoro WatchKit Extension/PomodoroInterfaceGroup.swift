//
//  PomodoroInterfaceGroup.swift
//  pomodoro
//
//  Created by MacBookPro on 3/12/16.
//  Copyright © 2016 MacBookPro. All rights reserved.
//

import WatchKit
import Foundation


class PomodoroInterfaceGroup: NSObject {
    var groupCircle: WKInterfaceGroup!
    struct framesStruct {
        var currentFrame = 0
        var max = 0
        var first = 0
        func percentToFrame (p:Double) -> Int {
            print("currentFrame\(currentFrame) max\(max) first\(first) p\(p) ")
            let dmax = Double(max)
            let dfirst = Double(first)
            let frameFloat = Int(round(p*(dmax - dfirst)/100))
            return ( (frameFloat-1) % max ) + 1
        }
    }
    var frames = framesStruct()
    var imageNameRoot = ""

    
    func setGroup (group: WKInterfaceGroup, totalFrames: Int, imageNameRoot: String) {
        self.groupCircle = group
        frames.max = totalFrames
        self.imageNameRoot = imageNameRoot
        groupCircle.setBackgroundImageNamed(imageNameRoot)
    }
    func changeImageName(imageNameRoot: String) {
        self.imageNameRoot = imageNameRoot
        groupCircle.setBackgroundImageNamed(imageNameRoot)
    }
    
    func startAnimationHelperWithCompletion(frameFrom:Int, frameTo: Int, duration: Double,completionHandler: @escaping () -> Void) {
        groupCircle.setBackgroundImageNamed(imageNameRoot)
        print("startAnimationHelperWithCompletion - frameFrom: \(frameFrom) frameTo: \(frameTo) duration: \(duration)")
        let delay = DispatchTime.now() + Double(Int64((duration+0.1) *
            Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        groupCircle.startAnimatingWithImages(in: NSRange(location: frameFrom, length: frameTo), duration: duration, repeatCount: 1)
        DispatchQueue.main.asyncAfter(deadline: delay) { () in
            completionHandler()
        }
    }
    func startAnimationPercentageProgress(frameFromPercent:Double, frameToPercent: Double, duration: Double) {
        print("startAnimationPercentageProgress - frameFromPercent: \(frameFromPercent) frameToPercent: \(frameToPercent) duration: \(duration)")
        let frameFrom = frames.percentToFrame(p: frameFromPercent)
        let frameTo = frames.percentToFrame(p: frameToPercent)
        startAnimationHelperWithCompletion(frameFrom: frameFrom, frameTo: frameTo, duration: duration, completionHandler: {()})
    }
    func startFastAnimationWithCompletion(completionHandler: @escaping () -> Void) {
        startAnimationHelperWithCompletion(frameFrom: 0, frameTo: frames.max, duration: 0.5, completionHandler: completionHandler)
    }
    func setFrame(frame:Int) {
        //startAnimationHelperWithCompletion(frameFrom: frame,frameTo: frame+1,duration: 0,completionHandler:{()})
        groupCircle.setBackgroundImageNamed("\(imageNameRoot)\(frame)")
    }
    func setFramePercentage(p:Double) {
        setFrame(frame: frames.percentToFrame(p: p))
    }
    func stopAnimating(){
        groupCircle.stopAnimating()
    }
    
    

}
