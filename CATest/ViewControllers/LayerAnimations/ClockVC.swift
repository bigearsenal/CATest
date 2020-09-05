//
//  ClockVC.swift
//  CATest
//
//  Created by Chung Tran on 8/30/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class ClockVC: BaseViewController {
    lazy var clockFace = UIView(width: 200, height: 200, cornerRadius: 100)
    lazy var hourHand = drawHand(size: 50, width: 5, color: .black)
    lazy var minuteHand = drawHand(size: 65, width: 3, color: .black)
    lazy var secondHand = drawHand(size: 75, width: 1, color: .red)
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockFace.layer.contents = UIImage(named: "watch-face")?.cgImage
        view.addSubview(clockFace)
        clockFace.autoCenterInSuperview()
        
        view.layoutIfNeeded()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        tick()
    }
    
    func drawHand(size: CGFloat, width: CGFloat, color: UIColor) -> UIView {
        let hand = UIView(width: width, height: size, backgroundColor: color)
        hand.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        clockFace.addSubview(hand)
        hand.autoCenterInSuperview()
        return hand
    }
    
    @objc func tick() {
        let calendar = Calendar(identifier: .gregorian)
        
        let components = calendar.dateComponents([.hour, .minute, .second], from: Date())
        let hoursAngle = CGFloat(components.hour!) / 12.0 * 2 * CGFloat.pi
        let minsAngle = CGFloat(components.minute!) / 60.0 * 2 * CGFloat.pi
        let secondsAngle = CGFloat(components.second!) / 60.0 * 2 * CGFloat.pi
        
        setAngle(hoursAngle, forHand: hourHand, animated: true)
        setAngle(minsAngle, forHand: minuteHand, animated: true)
        setAngle(secondsAngle, forHand: secondHand, animated: true)
    }
    
    func setAngle(_ angle: CGFloat, forHand hand: UIView, animated: Bool) {
        let transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        if animated {
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = hand.layer.presentation()?.value(forKey: "transform")
            animation.toValue = transform
            animation.duration = 0.5
            animation.timingFunction = CAMediaTimingFunction(controlPoints: 1, 0, 0.75, 1)
            hand.layer.transform = transform
            hand.layer.add(animation, forKey: nil)
        } else {
            hand.layer.transform = transform
        }
    }
}
