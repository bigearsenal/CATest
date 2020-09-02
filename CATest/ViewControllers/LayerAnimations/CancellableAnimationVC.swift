//
//  CancellableAnimationVC.swift
//  CATest
//
//  Created by Chung Tran on 8/28/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class CancellableAnimationVC: MovingAircraftVC {
    lazy var cancelButton = UIButton(label: "cancel", textColor: .red)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStackView.addArrangedSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    
    @objc func cancel() {
        shipLayer.removeAnimation(forKey: animationKey)
    }
}
