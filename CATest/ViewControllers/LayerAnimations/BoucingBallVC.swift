//
//  BoucingBallVC.swift
//  CATest
//
//  Created by Chung Tran on 8/30/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class BoucingBallVC: BaseViewController {
    lazy var ballView = UIView(width: 50, height: 50, backgroundColor: .red, cornerRadius: 25)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ballView)
        ballView.autoCenterInSuperview()
        animate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animate()
    }
    
    @objc func animate() {
        ballView.center = CGPoint(x: 150, y: 32)
        ballView.layer.position = CGPoint(x: 150, y: 268)
        ballView.layer.add(createAnimation(), forKey: nil)
    }
    
    func createAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 1
        animation.values = [
            CGPoint(x: 150, y: 32),
            CGPoint(x: 150, y: 268),
            CGPoint(x: 150, y: 140),
            CGPoint(x: 150, y: 268),
            CGPoint(x: 150, y: 220),
            CGPoint(x: 150, y: 268),
            CGPoint(x: 150, y: 220),
            CGPoint(x: 150, y: 268),
            CGPoint(x: 150, y: 250),
            CGPoint(x: 150, y: 268)
        ]
        
        animation.timingFunctions = [
            .init(name: .easeIn),
            .init(name: .easeOut),
            .init(name: .easeIn),
            .init(name: .easeOut),
            .init(name: .easeIn),
            .init(name: .easeOut),
            .init(name: .easeIn)
        ]
        
        animation.keyTimes = [0, 0.3, 0.5, 0.7, 0.8, 0.9, 0.95, 1]
        return animation
    }
}
