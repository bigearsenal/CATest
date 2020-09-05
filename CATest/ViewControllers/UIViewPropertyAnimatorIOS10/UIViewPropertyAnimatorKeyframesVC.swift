//
//  UIViewPropertyAnimatorKeyframesVC.swift
//  CATest
//
//  Created by Chung Tran on 9/5/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class UIViewPropertyAnimatorKeyframesVC: CenteredImageViewVC {
    
    override func imageViewDidTouch() {
        AnimatorFactory.jiggle(view: imageView)
    }
}
