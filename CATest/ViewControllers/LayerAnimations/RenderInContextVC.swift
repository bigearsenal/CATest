//
//  RenderInContextVC.swift
//  CATest
//
//  Created by Chung Tran on 8/28/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class RenderInContextVC: ButtonVC {
    override func animate() {
        // preserve the current view snapshot
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let coverImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // insert snapshot view in front of this one
        let coverView = UIImageView(image: coverImage)
        coverView.frame = view.bounds
        view.addSubview(coverView)
        
        view.backgroundColor = .random()
        
        UIView.animate(withDuration: 1, animations: {
            var transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            transform = transform.rotated(by: .pi/2)
            coverView.transform = transform
            coverView.alpha = 0
        }) { _ in
            coverView.removeFromSuperview()
        }
    }
}
