//
//  SplashRevealVC.swift
//  CATest
//
//  Created by Chung Tran on 9/4/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit
class SplashRevealVC: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {.lightContent}
    
    lazy var slashImageView = UIImageView(width: 60, height: 130.5, imageNamed: "slash")
    var errorView: UIView!
    
    var button = UIButton(backgroundColor: .red, cornerRadius: 4, label: "Push", textColor: .white, contentInsets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        view.addSubview(slashImageView)
        slashImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        slashImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        view.addSubview(button)
        button.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10)
        button.autoAlignAxis(toSuperviewAxis: .vertical)
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)
        
        navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        slashImageView.layer.removeAllAnimations()
        
        let zoomAnim = CABasicAnimation(keyPath: "transform.scale")
        zoomAnim.fromValue = 1
        zoomAnim.toValue = 1.2
        zoomAnim.duration = 0.8
        zoomAnim.repeatCount = .infinity
        zoomAnim.autoreverses = true
        slashImageView.layer.add(zoomAnim, forKey: "Loading")
    }
    
    @objc func animate() {
        show(VinylSongDetailVC(), sender: nil)
    }
}

extension SplashRevealVC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is SplashRevealVC && toVC is VinylSongDetailVC ||
            fromVC is VinylSongDetailVC && toVC is SplashRevealVC
        {
            let animator = RevealAnimator()
            animator.operation = operation
            return animator
        }
        return nil
    }
}

class RevealAnimator: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    weak var storedContext: UIViewControllerContextTransitioning?
    let duration = 0.3
    var operation = UINavigationController.Operation.push
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        storedContext = transitionContext
        
        if operation == .push {
            let fromVC = transitionContext.viewController(forKey: .from) as! SplashRevealVC
            let toVC = transitionContext.viewController(forKey: .to) as! VinylSongDetailVC
            
            transitionContext.containerView.addSubview(toVC.view)
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            
            let maskLayer = fromVC.slashImageView.snapshotView(afterScreenUpdates: false)!.layer
            maskLayer.position = fromVC.slashImageView.layer.position
            toVC.view.layer.mask = maskLayer
            
            // animate maskLayer
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.duration = duration
            animation.fromValue = 0.7
            animation.toValue = 30
            animation.delegate = self
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
            maskLayer.add(animation, forKey: "scale")
        } else if operation == .pop {
            let toVC = transitionContext.viewController(forKey: .to) as! SplashRevealVC
            
            let fromView = transitionContext.view(forKey: .from)!
            let toView = transitionContext.view(forKey: .to)!
            
            transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
            toView.transform = CGAffineTransform(scaleX: 30, y: 30)
            
            let maskLayer = toVC.slashImageView.snapshotView(afterScreenUpdates: false)!.layer
            maskLayer.position = toVC.slashImageView.layer.position
            maskLayer.transform = CATransform3DMakeScale(30, 30, 1)
            fromView.layer.mask = maskLayer
            
            // animate maskLayer
            UIView.animate(withDuration: duration, animations: {
                toView.transform = .identity
                maskLayer.transform = CATransform3DIdentity
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let context = storedContext {
            context.completeTransition(!context.transitionWasCancelled)
            let toVC = context.viewController(forKey: .to) as! VinylSongDetailVC
            toVC.view.layer.mask = nil
        }
        storedContext = nil
    }
    
}
