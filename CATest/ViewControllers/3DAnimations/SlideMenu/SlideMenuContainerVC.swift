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
    lazy var menuButton = UIButton(label: "+", labelFont: .systemFont(ofSize: 50), textColor: .blue)
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
        menuVC.view.layer.anchorPoint.x = 1
        menuVC.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        
        menuVC.didSelectMenuItem = {item in
            UIView.animate(withDuration: 0.3) {
                self.detailVC.view.backgroundColor = item.color
            }
            self.title = item.symbol
        }
        
        let panGesture = UIPanGestureRecognizer(target:self, action:#selector(handleGesture(_:)))
        view.addGestureRecognizer(panGesture)
        
        setMenu(toPercent: 0.0)
    }
    
    @objc func handleGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: recognizer.view!.superview!)
        
        var progress = translation.x / menuWidth * (isMenuOpen ? 1.0 : -1.0)
        progress = min(max(progress, 0.0), 1.0)
        
        switch recognizer.state {
        case .began:
            let isOpen = floor(detailVC.view.frame.origin.x/menuWidth)
            isMenuOpen = isOpen == 1.0 ? false: true
            // Core Animation continually redraws all contents of the menu view controller and recalculates the perspective distortion for all elements as it moves, which isn’t terribly efficient — hence the jagged edges.
            // It’s better to let Core Animation know that you won’t change the menu contents during the animation so that it can render the menu once and simply rotate the rendered and cached image.
            menuVC.view.layer.shouldRasterize = true
            menuVC.view.layer.rasterizationScale =
            UIScreen.main.scale
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
                            self.menuVC.view.layer.shouldRasterize = false
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
        menuVC.view.layer.transform = menuTransform(percent: percent)
        menuVC.view.alpha = CGFloat(max(0.2, percent))
        menuButton.layer.transform = buttonTransform(percent: percent)
    }
    
    func menuTransform(percent: CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1 / 1000
        
        let remainingPercent = 1 - percent
        let angle = remainingPercent * .pi * -0.5
        
        let rotationTransform = CATransform3DRotate(identity, angle, 0, 1, 0)
        let translationTranform = CATransform3DMakeTranslation(menuWidth * percent, 0, 0)
        
        return CATransform3DConcat(rotationTransform, translationTranform)
    }
    
    func buttonTransform(percent: CGFloat) -> CATransform3D {
        return CATransform3DMakeRotation(percent * .pi / 4, 0, 0, 1)
    }
}
