//
//  EasingKeyframeAnimationVC.swift
//  CATest
//
//  Created by Chung Tran on 8/30/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class EasingKeyframeAnimationVC: KeyframeAnimationsVC {
    override func createAnimation() -> CAAnimation {
        let animation = super.createAnimation() as! CAKeyframeAnimation
        let timingFunction = CAMediaTimingFunction(name: .easeIn)
        animation.timingFunctions = [timingFunction, timingFunction, timingFunction]
        return animation
    }
}
