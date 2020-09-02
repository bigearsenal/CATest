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
    lazy var button = UIButton(backgroundColor: .blue, cornerRadius: 10, label: "animate", textColor: .white, contentInsets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    lazy var contentView = UIView(forAutoLayout: ())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let stackView = UIStackView(axis: .vertical, spacing: 10, alignment: .center, distribution: .fill)
        view.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
        
        stackView.addArrangedSubview(contentView)
        stackView.addArrangedSubview(button)
        
        button.setContentHuggingPriority(.required, for: .vertical)
        
        button.addTarget(self, action: #selector(buttonAnimateDidTouch), for: .touchUpInside)
    }
    
    func resetState() {
        
    }
    
    func animate() {
        
    }
    
    @objc func buttonAnimateDidTouch() {
        resetState()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animate()
        }
    }
}
