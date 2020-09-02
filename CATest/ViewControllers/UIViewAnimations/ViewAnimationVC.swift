//
//  ViewAnimationVC.swift
//  CATest
//
//  Created by Chung Tran on 9/2/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class ViewAnimationVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetState()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animate()
        }
    }
    
    func resetState() {
        
    }
    
    func animate() {
        
    }
}
