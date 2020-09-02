//
//  LayerCustomTranstionVC.swift
//  CATest
//
//  Created by Chung Tran on 8/26/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import UIKit

class LayerCustomTranstionVC: SingleCubeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        let transition = CATransition()
        transition.type = .push
        transition.subtype = .fromLeft
        myLayer.actions = ["backgroundColor": transition]
    }
}

