//
//  CAAnimationDelegateVC.swift
//  CATest
//
//  Created by Chung Tran on 8/27/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class CAAnimationDelegateVC: SingleCubeVC, CAAnimationDelegate {
    override func changeColor() {
        let anim = CABasicAnimation(keyPath: "backgroundColor")
        anim.toValue = UIColor.random().cgColor
        anim.delegate = self
        myLayer.add(anim, forKey: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let anim = anim as! CABasicAnimation
        CATransaction.begin()
        // DISABLE IMPLICIT ANIMATIONS, OTHERWISE, THE ANIMATION WILL HAPPEN TWICE
        CATransaction.setDisableActions(true)
        // Change model layel to desired value
        myLayer.backgroundColor = anim.toValue as! CGColor
        CATransaction.commit()
    }
}
