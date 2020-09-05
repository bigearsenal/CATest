//
//  SlideMenuContainerVC.swift
//  CATest
//
//  Created by Chung Tran on 9/5/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class SlideMenuContainerVC: BaseViewController {
    let menuWidth: CGFloat = 80.0
    lazy var detailVC = VinylSongDetailVC()
    lazy var menuVC = SideMenuViewController()
    lazy var menuButton = UIButton(label: "toggle menu", textColor: .red)
    var isMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setNeedsStatusBarAppearanceUpdate()
        
        detailVC.view.addSubview(menuButton)
        menuButton.autoPinToTopLeftCornerOfSuperviewSafeArea()
        
        menuButton.addTarget(self, action: #selector(menuButtonDidTouch), for: .touchUpInside)
        
        addChild(detailVC)
        view.addSubview(detailVC.view)
        detailVC.didMove(toParent: self)
        
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        menuVC.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        
        menuVC.didSelectMenuItem = {item in
            UIView.animate(withDuration: 0.3) {
                self.detailVC.view.backgroundColor = item.color
            }
            self.title = item.symbol
        }
        
        let panGesture = UIPanGestureRecognizer(target:self, action:#selector(handleGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handleGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: recognizer.view!.superview!)
        
        var progress = translation.x / menuWidth * (isMenuOpen ? 1.0 : -1.0)
        progress = min(max(progress, 0.0), 1.0)
        
        switch recognizer.state {
        case .began:
            let isOpen = floor(detailVC.view.frame.origin.x/menuWidth)
            isMenuOpen = isOpen == 1.0 ? false: true
            
        case .changed:
            setMenu(toPercent: isMenuOpen ? progress: (1.0 - progress))
            
        case .ended: fallthrough
        case .cancelled: fallthrough
        case .failed:
            
            var targetProgress: CGFloat
            if (isMenuOpen) {
                targetProgress = progress < 0.5 ? 0.0 : 1.0
            } else {
                targetProgress = progress < 0.5 ? 1.0 : 0.0
            }
            
            UIView.animate(withDuration: 0.3,
                           animations: {
                            self.setMenu(toPercent: targetProgress)
            },
                           completion: {_ in
                            
            }
            )
            
        default: break
        }
    }
    
    @objc func menuButtonDidTouch() {
        isMenuOpen.toggle()
        UIView.animate(withDuration: 0.3) {
            self.setMenu(toPercent: self.isMenuOpen ? 1 : 0)
        }
    }
    
    func setMenu(toPercent percent: CGFloat) {
        detailVC.view.frame.origin.x = menuWidth * CGFloat(percent)
        menuVC.view.frame.origin.x = menuWidth * CGFloat(percent) - menuWidth
    }
}
