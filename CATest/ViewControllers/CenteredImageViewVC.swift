//
//  CenteredImageViewVC.swift
//  CATest
//
//  Created by Chung Tran on 9/5/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class CenteredImageViewVC: BaseViewController {
    let imageView = UIImageView(width: 100, height: 100, cornerRadius: 20, imageNamed: "dog")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.autoCenterInSuperview()
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewDidTouch)))
    }
    
    @objc func imageViewDidTouch() {
        
    }
}
