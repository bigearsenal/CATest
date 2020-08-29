//
//  TimeOffsetAndSpeedVC.swift
//  CATest
//
//  Created by Chung Tran on 8/29/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class TimeOffsetAndSpeedVC: MovingAircraftVC {
    lazy var speedSlider = UISlider(width: 100)
    lazy var timeOffsetSlider = UISlider(width: 100)
    lazy var timeOffsetLabel = UILabel(text: "timeOffset", textColor: .black)
    lazy var speedLabel = UILabel(text: "speed", textColor: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let labelStackView = UIStackView(axis: .vertical, spacing: 10)
        labelStackView.addArrangedSubview(timeOffsetLabel)
        labelStackView.addArrangedSubview(speedLabel)
        
        let sliderStackView = UIStackView(axis: .vertical, spacing: 10)
        sliderStackView.addArrangedSubview(timeOffsetSlider)
        sliderStackView.addArrangedSubview(speedSlider)
        
        let stackView = UIStackView(axis: .horizontal, spacing: 10)
        stackView.addArrangedSubview(labelStackView)
        stackView.addArrangedSubview(sliderStackView)
        
        view.addSubview(stackView)
        stackView.autoAlignAxis(toSuperviewAxis: .vertical)
        stackView.autoPinEdge(.bottom, to: .top, of: buttonStackView)
        
        speedSlider.addTarget(self, action: #selector(updateSliders), for: .valueChanged)
        timeOffsetSlider.addTarget(self, action: #selector(updateSliders), for: .valueChanged)
        
        updateSliders()
    }
    
    @objc func updateSliders() {
        let timeOffset = timeOffsetSlider.value
        
        timeOffsetLabel.text = String(format: "TimeOffset %0.2f", timeOffset)
        
        let speed = speedSlider.value
        speedLabel.text = String(format: "Speed %0.2f", speed)
    }
    
    override func animate() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.timeOffset = CFTimeInterval(timeOffsetSlider.value)
        animation.speed = speedSlider.value
        animation.duration = 1
        animation.path = path.cgPath
        animation.rotationMode = .rotateAuto
        animation.isRemovedOnCompletion = false
        shipLayer.add(animation, forKey: "slide")
    }
}
