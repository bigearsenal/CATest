//
//  BouncingBallTimer.swift
//  CATest
//
//  Created by Chung Tran on 9/1/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class BouncingBallTimer: BouncingFunctionVC {
    var timer: Timer!
    var duration: TimeInterval!
    var timeOffset: TimeInterval!
    var from: CGPoint!
    var to: CGPoint!
    override func animate() {
        // reset position of ballView
        ballView.center = CGPoint(x: 150, y: 32)
        
        // configure the animation
        duration = 1
        timeOffset = 0
        from = CGPoint(x: 150, y: 32)
        to = CGPoint(x: 150, y: 268)
        
        startTheTimer()
    }
    
    func startTheTimer() {
        // stop the running timer
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1 / 60, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
    
    @objc func step() {
        // update timeOffset
        timeOffset = min(timeOffset + 1 / 60, duration)
        
        // get normalized time offset (in range 0 - 1)
        var time: CGFloat = CGFloat(timeOffset) / CGFloat(duration)
        
        // apply easing
        time = bounceEaseOut(time)
        
        // interpolate position
        let position = interpolate(from: from, to: to, time: time)
        
        // move ball view to new position
        ballView.center = position
        
        // stop the timer if we're reached the end of the animation
        if timeOffset > duration {
            timer.invalidate()
            timer = nil
        }
    }
}
