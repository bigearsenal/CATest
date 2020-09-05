//
//  BlurAnimationVC.swift
//  CATest
//
//  Created by Chung Tran on 9/5/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class BlurAnimationVC: CenteredImageViewVC {
    var blured = true
    lazy var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        
        blurView.frame = imageView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        imageView.addSubview(blurView)
    }
    
    func blurAnimations(_ blurred: Bool) -> () -> Void {
        return {
            self.blurView.effect = blurred ? UIBlurEffect(style: .dark) : nil
        }
    }
    
    override func imageViewDidTouch() {
        blured.toggle()
        UIViewPropertyAnimator(
            duration: 0.55,
            curve: .easeOut,
            animations: blurAnimations(blured)
        ).startAnimation()
    }
}
