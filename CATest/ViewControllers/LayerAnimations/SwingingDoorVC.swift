//
//  SwingingDoorVC.swift
//  CATest
//
//  Created by Chung Tran on 8/28/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class SwingingDoorVC: BaseViewController {
    lazy var doorLayer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        let behindTheDoorLayer = CALayer()
        behindTheDoorLayer.frame = CGRect(x: 0, y: 0, width: 128, height: 256)
        behindTheDoorLayer.position = view.center
        behindTheDoorLayer.contents = UIImage(named: "behind-the-door")!.cgImage
        view.layer.addSublayer(behindTheDoorLayer)
        
        doorLayer.frame = behindTheDoorLayer.frame
        doorLayer.position = CGPoint(x: behindTheDoorLayer.position.x - 64, y: behindTheDoorLayer.position.y)
        doorLayer.anchorPoint = CGPoint(x: 0, y: 0.5)
        doorLayer.contents = UIImage(named: "door")!.cgImage
        view.layer.addSublayer(doorLayer)
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1/500
        view.layer.sublayerTransform = perspective
        
        addAnimation()
    }
    
    func addAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.toValue = -CGFloat.pi/2
        animation.duration = 2
        animation.repeatCount = .infinity
        animation.autoreverses = true
        
        doorLayer.add(animation, forKey: nil)
    }
}
