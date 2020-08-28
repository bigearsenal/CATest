//
//  TransitionVC.swift
//  CATest
//
//  Created by Chung Tran on 8/28/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class TransitionVC: UIViewController {
    let images: [UIImage] = ["aircraft", "dog", "cat", "pig"].map {UIImage(named: $0)!}
    lazy var imageView = UIImageView(width: 200, height: 200)
    lazy var button = UIButton(label: "animate")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.autoCenterInSuperview()
        
        view.addSubview(button)
        button.autoPinEdge(toSuperviewEdge: .bottom)
        button.autoAlignAxis(toSuperviewAxis: .vertical)
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)
    }
    
    @objc func animate() {
        let transition = CATransition()
        transition.type = .fade
        
        imageView.layer.add(transition, forKey: nil)
        
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
