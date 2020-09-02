//
//  TransitionUIKitVC.swift
//  CATest
//
//  Created by Chung Tran on 8/28/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class TranstionUIKitVC: TransitionVC {
    override func animate() {
        UIView.transition(with: imageView, duration: 1, options: .transitionFlipFromLeft, animations: {
            self.changeImage()
        })
    }
}
