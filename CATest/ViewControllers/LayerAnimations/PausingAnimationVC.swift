//
//  PausingAnimationVC.swift
//  CATest
//
//  Created by Chung Tran on 8/29/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class PausingAnimation: SwingingDoorVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    override func addAnimation() {
        // pause all layer animations
        doorLayer.speed = 0
        
        //apply swinging animation (which won't play because layer is paused)
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.toValue = -CGFloat.pi/2
        animation.duration = 2
        doorLayer.add(animation, forKey: nil)
    }
    
    @objc func pan(_ gesture: UIPanGestureRecognizer) {
        //get horizontal component of pan gesture
        var x = gesture.translation(in: view).x
        
        //convert from points to animation duration
        //using a reasonable scale factor
        x/=200
        
        var timeOffset = doorLayer.timeOffset
        timeOffset = min(0.999, max(0, timeOffset - Double(x)))
        doorLayer.timeOffset = timeOffset
        
        gesture.setTranslation(.zero, in: view)
    }
}
