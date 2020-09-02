//
//  ViewKeyframeAnimationVC.swift
//  CATest
//
//  Created by Chung Tran on 9/2/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class ViewKeyframeAnimationVC: ViewAnimationVC {
    lazy var planeImage = UIImageView(width: 99, height: 66, imageNamed: "aircraft")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.addSubview(planeImage)
        planeImage.autoCenterInSuperview()
    }
    
    override func resetState() {
        planeImage.setNeedsLayout()
    }
    
    override func animate() {
        let originalCenter = planeImage.center
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, animations: {
            //add keyframes
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                self.planeImage.center.x += 80.0
                self.planeImage.center.y -= 10.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4) {
                self.planeImage.transform = CGAffineTransform(rotationAngle: -.pi / 8)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.planeImage.center.x += 100.0
                self.planeImage.center.y -= 50.0
                self.planeImage.alpha = 0.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
                self.planeImage.transform = .identity
                self.planeImage.center = CGPoint(x: 0.0, y: originalCenter.y)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
                self.planeImage.alpha = 1.0
                self.planeImage.center = originalCenter
            }
        }, completion: nil)
    }
}
