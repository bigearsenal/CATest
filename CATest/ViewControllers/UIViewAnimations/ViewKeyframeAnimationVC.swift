//
//  ViewKeyframeAnimationVC.swift
//  CATest
//
//  Created by Chung Tran on 9/2/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class ViewKeyframeAnimationVC: ViewAnimationVC {
    lazy var airplane = UIImageView(width: 66, height: 44, imageNamed: "aircraft")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.addSubview(airplane)
        airplane.autoCenterInSuperview()
    }
    
    
}
