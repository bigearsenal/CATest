//
//  EasingAnimationVC.swift
//  CATest
//
//  Created by Chung Tran on 8/30/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class EasingAnimationVC: MovingAircraftVC {
    override func createAnimation() -> CAAnimation {
        let anim = super.createAnimation()
        anim.timingFunction = .init(name: .default)
        return anim
    }
}
