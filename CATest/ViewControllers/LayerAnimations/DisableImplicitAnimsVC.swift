//
//  DisableImplicitAnimsVC.swift
//  CATest
//
//  Created by Chung Tran on 8/27/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class DisableImplicitAnimsVC: SingleCubeVC {
    override func changeColor() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.toValue = UIColor.random().cgColor
        
        myLayer.apply(animation)
    }
}
