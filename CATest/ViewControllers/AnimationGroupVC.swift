//
//  AnimationGroupVC.swift
//  CATest
//
//  Created by Chung Tran on 8/27/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class AnimationGroupVC: MovingAircraftVC, CAAnimationDelegate {
    override func animate() {
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.path = path.cgPath
        pathAnimation.rotationMode = .rotateAuto
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 4
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [pathAnimation, scaleAnimation]
        groupAnimation.duration = 4
        groupAnimation.delegate = self
        shipLayer.add(groupAnimation, forKey: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        shipLayer.position = path.currentPoint
        shipLayer.transform = CATransform3DMakeScale(4, 4, 1)
        CATransaction.commit()
    }
}
