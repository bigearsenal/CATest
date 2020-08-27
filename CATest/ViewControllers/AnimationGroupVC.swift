//
//  AnimationGroupVC.swift
//  CATest
//
//  Created by Chung Tran on 8/27/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class AnimationGroupVC: MovingAircraftVC {
    override func animate() {
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.path = path.cgPath
        pathAnimation.rotationMode = .rotateAuto
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = 4
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [pathAnimation, scaleAnimation]
        groupAnimation.duration = 4
        
        shipLayer.add(groupAnimation, forKey: nil)
    }
}
