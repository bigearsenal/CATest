//
//  BouncingBallCADisplayLinkVC.swift
//  CATest
//
//  Created by Chung Tran on 9/1/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class BouncingBallCADisplayLink: BouncingBallTimer {
    var displayLink: CADisplayLink!
    var lastStep: TimeInterval!
    
    override func startTheTimer() {
        displayLink?.invalidate()
        
        lastStep = CACurrentMediaTime()
        displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink.add(to: .main, forMode: .default)
    }
    
    override func step() {
        let thisStep = CACurrentMediaTime()
        let stepDuration = thisStep - lastStep
        lastStep = thisStep
        
        timeOffset = min(timeOffset + stepDuration, duration)
        var time: CGFloat = CGFloat(timeOffset) / CGFloat(duration)
        
        time = bounceEaseOut(time)
        
        let position = interpolate(from: from, to: to, time: time)
        
        ballView.center = position
        
        if timeOffset >= duration {
            displayLink.invalidate()
            displayLink = nil
        }
    }
}
