//
//  CrossfadingAnimationVC.swift
//  CATest
//
//  Created by Chung Tran on 9/2/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func fade(to image: UIImage, duration: TimeInterval = 0.25, completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: completion)
    }
}


class CrossfadingAnimationVC: ViewAnimationVC {
    lazy var imageView = UIImageView(imageNamed: "bg-sunny")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.addSubview(imageView)
        imageView.autoPinEdgesToSuperviewEdges()
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    override func resetState() {
        imageView.image = UIImage(named: "bg-sunny")
    }
    
    override func animate() {
        imageView.fade(to: UIImage(named: "bg-snowy")!, duration: 1)
    }
}
