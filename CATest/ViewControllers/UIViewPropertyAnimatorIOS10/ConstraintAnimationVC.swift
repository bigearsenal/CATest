//
//  ConstraintAnimationVC.swift
//  CATest
//
//  Created by Chung Tran on 9/5/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class ConstraintAnimationVC: CenteredImageViewVC {
    override func imageViewDidTouch() {
        let spring = UISpringTimingParameters(dampingRatio: 0.5, initialVelocity: CGVector(dx: 1, dy: 0.2))
        let animator = UIViewPropertyAnimator(duration: 2, timingParameters: spring)
        
        animator.addAnimations {
            self.view.constraints.first(where: {$0.firstAttribute == .centerX})?.constant = 100
            self.view.layoutIfNeeded()
        }
        
        animator.startAnimation()
    }
}
