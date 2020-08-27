//
//  SingleCubeVC.swift
//  CATest
//
//  Created by Chung Tran on 8/27/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import BEPureLayout

class SingleCubeVC: UIViewController {
    lazy var containerView = UIView(width: 400, height: 400, backgroundColor: .red)
    lazy var button = UIButton(label: "change color")
    lazy var myLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        view.addSubview(containerView)
        containerView.autoCenterInSuperview()
        
        view.addSubview(button)
        button.autoCenterInSuperview()
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        
        view.layoutIfNeeded()
        myLayer.backgroundColor = UIColor.blue.cgColor
        myLayer.frame = containerView.bounds
        
        containerView.layer.addSublayer(myLayer)
    }
    
    @objc func changeColor() {
        myLayer.backgroundColor = UIColor.random().cgColor
    }
}
