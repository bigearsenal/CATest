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
    lazy var buttonStackView = UIStackView(axis: .horizontal, spacing: 16, alignment: .fill, distribution: .fill)
    lazy var animateButton = UIButton(label: "animate", textColor: .blue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(buttonStackView)
        buttonStackView.autoPinEdge(toSuperviewEdge: .bottom)
        buttonStackView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        buttonStackView.addArrangedSubview(animateButton)
        animateButton.addTarget(self, action: #selector(animate), for: .touchUpInside)
    }
    
    @objc func animate() {
        
    }
}
