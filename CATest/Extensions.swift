//
//  Extensions.swift
//  CATest
//
//  Created by Chung Tran on 8/27/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func apply(_ anim: CABasicAnimation) {
        guard let key = anim.keyPath else {return}
        anim.fromValue = (presentation() ?? self).value(forKeyPath: key)
        
        // disable implicit animation
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        setValue(anim.toValue, forKey: key)
        CATransaction.commit()
        
        add(anim, forKey: nil)
    }
}
