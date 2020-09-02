//
//  KeyframeAnimationsVC.swift
//  CATest
//
//  Created by Chung Tran on 8/27/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class KeyframeAnimationsVC: SingleCubeVC {
    override func changeColor() {
        myLayer.add(createAnimation(), forKey: nil)
    }
    
    func createAnimation() -> CAAnimation {
        let animation = CAKeyframeAnimation(keyPath: "backgroundColor")
        animation.duration = 2
        animation.values = [UIColor.blue.cgColor, UIColor.random().cgColor, UIColor.random().cgColor, UIColor.blue.cgColor]
        return animation
    }
}
