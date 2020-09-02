//
//  TransitionTabBarVC.swift
//  CATest
//
//  Created by Chung Tran on 8/28/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class TransitionTabBarVC: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers?.first?.view.backgroundColor = .red
        viewControllers?.last?.view.backgroundColor = .blue
        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == selectedViewController {return false}
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let transition = CATransition()
        transition.type = .push
        
        if viewController == viewControllers?.first {
            transition.subtype = .fromLeft
        } else {
            transition.subtype = .fromRight
        }
        
        
        view.layer.add(transition, forKey: nil)
    }
}
