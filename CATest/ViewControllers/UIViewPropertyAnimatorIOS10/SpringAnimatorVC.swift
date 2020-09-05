//
//  SpringAnimatorVC.swift
//  CATest
//
//  Created by Chung Tran on 9/5/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class SpringAnimatorVC: CenteredImageViewVC {
    override func imageViewDidTouch() {
        let spring = UISpringTimingParameters(dampingRatio:0.5, initialVelocity: CGVector(dx: 1.0, dy: 0.2))
        let animator = UIViewPropertyAnimator(duration: 1, timingParameters: spring)
        animator.addAnimations {
            if self.imageView.transform == .identity {
                self.imageView.transform = CGAffineTransform(scaleX: 3, y: 3)
            } else {
                self.imageView.transform = .identity
            }
        }
        animator.startAnimation()
    }
}
