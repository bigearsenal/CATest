//
//  ButtonVC.swift
//  CATest
//
//  Created by Chung Tran on 8/28/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class ButtonVC: UIViewController {
    lazy var button = UIButton(label: "animate")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.autoPinEdge(toSuperviewEdge: .bottom)
        button.autoAlignAxis(toSuperviewAxis: .vertical)
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)
    }
    
    @objc func animate() {
        
    }
}
