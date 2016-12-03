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

    func setGroup (group: WKInterfaceGroup) {
        self.groupCircle = group
    }
    
    func startFastAnimation() {
        groupCircle.setBackgroundImageNamed("circle-")
        groupCircle.startAnimatingWithImages(in: NSRange(location: 0, length: 100), duration: 0.5, repeatCount: 1)
    }

}
