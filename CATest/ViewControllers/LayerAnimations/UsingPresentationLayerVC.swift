//
//  UsingPresentationLayerVC.swift
//  CATest
//
//  Created by Chung Tran on 8/27/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class UsingPresentationLayerVC: BaseViewController {
    lazy var myLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        myLayer.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        
        myLayer.backgroundColor = UIColor.red.cgColor
        
        view.layer.addSublayer(myLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self.view) else {return}
        
        // Capture presentationLayer to change the color when layer is animating
        if ((myLayer.presentation()?.hitTest(point)) != nil) {
            myLayer.backgroundColor = UIColor.random().cgColor
        } else {
            CATransaction.begin()
            CATransaction.setAnimationDuration(4)
            myLayer.position = point
            CATransaction.commit()
        }
    }
}
