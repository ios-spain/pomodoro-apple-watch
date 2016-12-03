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
    }
    var frames = framesStruct()
    var imageNameRoot = ""

    
    func setGroup (group: WKInterfaceGroup, totalFrames: Int, imageNameRoot: String) {
        self.groupCircle = group
        frames.max = totalFrames
        self.imageNameRoot = imageNameRoot
        groupCircle.setBackgroundImageNamed(imageNameRoot)
    }
    func startAnimationHelperWithCompletion(frameFrom:Int, frameTo: Int, duration: Double,completionHandler: @escaping () -> Void) {
        let delay = DispatchTime.now() + Double(Int64((duration+0.1) *
            Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        groupCircle.startAnimatingWithImages(in: NSRange(location: frameFrom, length: frameTo), duration: duration, repeatCount: 1)
        DispatchQueue.main.asyncAfter(deadline: delay) { () in
            completionHandler()
        }
    }
    func startFastAnimationWithCompletion(completionHandler: @escaping () -> Void) {
        startAnimationHelperWithCompletion(frameFrom: 0, frameTo: frames.max, duration: 0.5, completionHandler: completionHandler)
    }
    func setFrame(frame:Int) {
        startAnimationHelperWithCompletion(frameFrom: frame,frameTo: frame+1,duration: 0,completionHandler:{()})
    }
    
    

}
