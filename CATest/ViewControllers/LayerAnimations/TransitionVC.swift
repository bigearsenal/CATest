//
//  TransitionVC.swift
//  CATest
//
//  Created by Chung Tran on 8/28/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class TransitionVC: ButtonVC {
    let images: [UIImage] = ["aircraft", "dog", "cat", "pig"].map {UIImage(named: $0)!}
    lazy var imageView = UIImageView(width: 200, height: 200)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.autoCenterInSuperview()
    }
    
    override func animate() {
        let transition = CATransition()
        transition.type = .fade
        
        imageView.layer.add(transition, forKey: nil)
        
        changeImage()
    }
    
    func changeImage() {
        if let currentImage = imageView.image,
            var index = images.firstIndex(of: currentImage)
        {
            index = (index + 1) % images.count
            imageView.image = images[index]
        } else {
            imageView.image = images.first!
        }
    }
}
