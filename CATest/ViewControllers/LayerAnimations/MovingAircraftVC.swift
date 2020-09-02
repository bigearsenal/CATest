//
//  MovingAircraftVC.swift
//  CATest
//
//  Created by Chung Tran on 8/27/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class AircraftVC: ButtonVC {
    lazy var shipLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shipLayer.frame = CGRect(x: 0, y: 0, width: 66, height: 44)
        shipLayer.position = CGPoint(x: 33, y: 150)
        shipLayer.contents = UIImage(named: "aircraft")?.cgImage
        view.layer.addSublayer(shipLayer)
    }
}

class MovingAircraftVC: AircraftVC {
    let animationKey = "moving"
    lazy var path = UIBezierPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        path.move(to: CGPoint(x: 33, y: 150))
        path.addCurve(to: CGPoint(x: 330, y: 150), controlPoint1: CGPoint(x: 88, y: 0), controlPoint2: CGPoint(x: 258, y: 300))
        
        let pathLayer = CAShapeLayer()
        pathLayer.path = path.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3
        view.layer.addSublayer(pathLayer)
    }
    
    override func animate() {
        shipLayer.add(createAnimation(), forKey: animationKey)
    }
    
    func createAnimation() -> CAAnimation {
        // animation
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 4
        animation.path = path.cgPath
        animation.rotationMode = .rotateAuto
        return animation
    }
}
