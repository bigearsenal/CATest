//
//  VirtualPropertyAnimsVC.swift
//  CATest
//
//  Created by Chung Tran on 8/27/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class VirtualPropertyAnimsVC: AircraftVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        shipLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        shipLayer.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2 - 100)
    }
    
    override func animate() {
//        let animation = CABasicAnimation(keyPath: "transform")
//        animation.duration = 2
//        animation.byValue = CATransform3DMakeRotation(.pi, 0, 0, 1)
//        shipLayer.add(animation, forKey: nil)
        
        // ROTATION IS THE VIRTUAL PROPERTY, INSTEAD OF TRANSFORM ALONE
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = 2
        animation.byValue = 2*CGFloat.pi
        shipLayer.add(animation, forKey: nil)
    }
}
