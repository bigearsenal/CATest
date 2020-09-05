//
//  UIViewPropertyAnimatorVC.swift
//  CATest
//
//  Created by Chung Tran on 9/5/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class UIViewPropertyAnimatorVC: BaseViewController {
    lazy var imageView = UIImageView(width: 300, height: 200, backgroundColor: .red, imageNamed: "dog", contentMode: .scaleToFill)
    lazy var scale = UIViewPropertyAnimator(duration: 0.33, curve: .easeIn)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.autoCenterInSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.transform = CGAffineTransform(scaleX: 0.67, y: 0.67)
        imageView.alpha = 0
        
        scale.startAnimation()
        
        // There’s a class method on UIViewPropertyAnimator that creates an animator and starts it right away for you.
//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((UIViewAnimatingPosition) -> Void)?##((UIViewAnimatingPosition) -> Void)?##(UIViewAnimatingPosition) -> Void#>)
        // actually does return an animator instance. So you can add more animations, more completion blocks, and generally interact with the animations that are currently running.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scale.addAnimations {
            self.imageView.alpha = 1
        }
        
        scale.addAnimations ({
            self.imageView.transform = .identity
        }, delayFactor: 0.33)
        
        scale.addCompletion {_ in
          print("ready")
        }
    }
}
