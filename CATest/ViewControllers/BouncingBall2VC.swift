//
//  BouncingBall2VC.swift
//  CATest
//
//  Created by Chung Tran on 9/1/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class BouncingBall2VC: BoucingBallVC {
    func interpolate(from: CGFloat, to: CGFloat, time: CGFloat) -> CGFloat {
        (to - from) * time + from
    }
    
    func interpolate(from: CGPoint, to: CGPoint, time: CGFloat) -> CGPoint {
        CGPoint(x: interpolate(from: from.x, to: to.x, time: time), y: interpolate(from: from.y, to: to.y, time: time))
    }
    
    override func createAnimation() -> CAKeyframeAnimation {
        let from = CGPoint(x: 150, y: 32)
        let to = CGPoint(x: 150, y: 268)
        let duration = 1.0
        
        let numFrames: Int = Int(duration * 60)
        var frames = [CGPoint]()
        for i in 0..<numFrames {
            var time: CGFloat = 1 / CGFloat(numFrames) * CGFloat(i)
            time = applyBouncing(time)
            frames.append(interpolate(from: from, to: to, time: time))
        }
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = duration
        animation.values = frames
        return animation
    }
    
    func applyBouncing(_ time: CGFloat) -> CGFloat {
        // apply nothing
        time
    }
}
