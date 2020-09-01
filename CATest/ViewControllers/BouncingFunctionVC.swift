//
//  BouncingFunctionVC.swift
//  CATest
//
//  Created by Chung Tran on 9/1/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class BouncingFunctionVC: BouncingBall2VC {
    // The math behind easing is nontrivial, but fortunately we don’t need to implement it from first principles. Robert Penner has a web page devoted to easing functions (http://www.robertpenner.com/easing) that contains links to public domain code samples for all common (and some less-common) easing functions in multiple programming languages, including C. Here is an example of an ease-in-ease-out function. (There are actually several different ways to implement ease-in-ease-out.)
    
    func quadraticEaseInOut(_ t: CGFloat) -> CGFloat {
        (t < 0.5) ? 2 * t * t : (-2 * t * t) + (4 * t) - 1
    }
    
    func bounceEaseOut(_ t: CGFloat) -> CGFloat {
        if (t < 4/11.0) { return (121 * t * t)/16.0 }
        else if (t < 8/11.0) {return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0 }
        else if (t < 9/10.0) {return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0}
        return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0
    }
    
    override func applyBouncing(_ time: CGFloat) -> CGFloat {
        bounceEaseOut(time)
    }
}
