//
//  VinylPlayerVC.swift
//  CATest
//
//  Created by Chung Tran on 9/3/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class VinylDiskVC: UIViewController {
    lazy var vinylDisk: UIImageView = {
        let view = UIImageView(cornerRadius: 35, imageNamed: "vinyl")
        view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        return view
    }()
    lazy var titleLabel = UILabel(text: "Lối nhỏ", textSize: 20, weight: .bold)
    lazy var subtitleLabel = UILabel(text: "Đen vâu ft Phương Anh", textSize: 15, weight: .medium, textColor: .lightGray, numberOfLines: 0)
    
    func rotateVinylDisk() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = CGFloat.pi * 2
        animation.duration = 3
        animation.repeatCount = .greatestFiniteMagnitude
        vinylDisk.layer.add(animation, forKey: nil)
    }
}

class VinylPlayerVC: VinylDiskVC {
    lazy var bottomView = UIView(height: 125, backgroundColor: .white, cornerRadius: 25)
    lazy var detailButton = UIButton(backgroundColor: .red, cornerRadius: 10, label: "Mở rộng", textColor: .white, contentInsets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(bottomView)
        bottomView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: -25, right: 0), excludingEdge: .top)
        
        let stackView = UIStackView(axis: .horizontal, spacing: 16, alignment: .center, distribution: .fill)
        bottomView.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 15, left: 15, bottom: 15 + 25, right: 15))
        
        let vStack: UIStackView = {
            let stackView = UIStackView(axis: .vertical, spacing: 4, alignment: .fill, distribution: .fill)
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(subtitleLabel)
            return stackView
        }()
        
        stackView.addArrangedSubview(vinylDisk)
        stackView.addArrangedSubview(vStack)
        stackView.addArrangedSubview(detailButton)
        
        detailButton.addTarget(self, action: #selector(buttonListenDidTouch), for: .touchUpInside)
        detailButton.setContentHuggingPriority(.required, for: .horizontal)
        
        view.layoutIfNeeded()
        
        // animate vinyl disk
        rotateVinylDisk()
    }
    
    
    
    @objc func buttonListenDidTouch() {
        let vc = VinylSongDetailVC()
        vc.modalPresentationStyle = .fullScreen
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension VinylPlayerVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentingAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DismissingAnimator()
    }
}

class PresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.3
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let nc = transitionContext.viewController(forKey: .from) as? UINavigationController,
            let fromVC = nc.topViewController as? VinylPlayerVC,
            let toVC = transitionContext.viewController(forKey: .to) as? VinylSongDetailVC
        else {
            transitionContext.completeTransition(true)
            return
        }
        // Prepare
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.sendSubviewToBack(toVC.view)
        
        guard let destinationVinylDisk = toVC.vinylDisk.snapshotView(afterScreenUpdates: true),
            let destinationTitleLabel = toVC.titleLabel.snapshotView(afterScreenUpdates: true),
            let destinationSubtitleLabel = toVC.subtitleLabel.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        fromVC.vinylDisk.alpha = 0
        fromVC.titleLabel.alpha = 0
        fromVC.subtitleLabel.alpha = 0
        toVC.vinylDisk.alpha = 0
        toVC.titleLabel.alpha = 0
        toVC.subtitleLabel.alpha = 0
        
        let relativeVinylDiskFrame = frameOfViewInWindowsCoordinateSystem(fromVC.vinylDisk)
        let destinationVinylDiskFrame = frameOfViewInWindowsCoordinateSystem(toVC.vinylDisk)
        destinationVinylDisk.frame = relativeVinylDiskFrame
        containerView.addSubview(destinationVinylDisk)
        
        let relativeTitleLabelFrame = frameOfViewInWindowsCoordinateSystem(fromVC.titleLabel)
        let destinationTitleLabelFrame = frameOfViewInWindowsCoordinateSystem(toVC.titleLabel)
        destinationTitleLabel.frame = relativeTitleLabelFrame
        containerView.addSubview(destinationTitleLabel)
        
        let relativeSubtitleLabelFrame = frameOfViewInWindowsCoordinateSystem(fromVC.subtitleLabel)
        let destinationSubtitleLabelFrame = frameOfViewInWindowsCoordinateSystem(toVC.subtitleLabel)
        destinationSubtitleLabel.frame = relativeSubtitleLabelFrame
        containerView.addSubview(destinationSubtitleLabel)
        
        UIView.animate(withDuration: duration, animations: {
            destinationVinylDisk.frame = destinationVinylDiskFrame
            destinationTitleLabel.frame = destinationTitleLabelFrame
            destinationSubtitleLabel.frame = destinationSubtitleLabelFrame
            nc.view.alpha = 0
        }) { (_) in
            destinationVinylDisk.removeFromSuperview()
            destinationTitleLabel.removeFromSuperview()
            destinationSubtitleLabel.removeFromSuperview()
            transitionContext.completeTransition(true)
            fromVC.vinylDisk.alpha = 1
            fromVC.titleLabel.alpha = 1
            fromVC.subtitleLabel.alpha = 1
            nc.view.alpha = 1
            toVC.vinylDisk.alpha = 1
            toVC.titleLabel.alpha = 1
            toVC.subtitleLabel.alpha = 1
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func frameOfViewInWindowsCoordinateSystem(_ view: UIView) -> CGRect {
        if let superview = view.superview {
            return superview.convert(view.frame, to: nil)
        }
        print("[ANIMATION WARNING] Seems like this view is not in views hierarchy\n\(view)\nOriginal frame returned")
        return view.frame
    }
}

class DismissingAnimator: PresentingAnimator {
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? VinylSongDetailVC,
            let nc = transitionContext.viewController(forKey: .to) as? UINavigationController,
            let toVC = nc.topViewController as? VinylPlayerVC
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        // Prepare
        let containerView = transitionContext.containerView
        containerView.addSubview(nc.view)
        containerView.sendSubviewToBack(nc.view)
        
        guard let destinationVinylDisk = toVC.vinylDisk.snapshotView(afterScreenUpdates: true),
            let destinationTitleLabel = toVC.titleLabel.snapshotView(afterScreenUpdates: true),
            let destinationSubtitleLabel = toVC.subtitleLabel.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        fromVC.vinylDisk.alpha = 0
        fromVC.titleLabel.alpha = 0
        fromVC.subtitleLabel.alpha = 0
        toVC.vinylDisk.alpha = 0
        toVC.titleLabel.alpha = 0
        toVC.subtitleLabel.alpha = 0
        
        let relativeVinylDiskFrame = frameOfViewInWindowsCoordinateSystem(fromVC.vinylDisk)
        let destinationVinylDiskFrame = frameOfViewInWindowsCoordinateSystem(toVC.vinylDisk)
        destinationVinylDisk.frame = relativeVinylDiskFrame
        containerView.addSubview(destinationVinylDisk)
        
        let relativeTitleLabelFrame = frameOfViewInWindowsCoordinateSystem(fromVC.titleLabel)
        let destinationTitleLabelFrame = frameOfViewInWindowsCoordinateSystem(toVC.titleLabel)
        destinationTitleLabel.frame = relativeTitleLabelFrame
        containerView.addSubview(destinationTitleLabel)
        
        let relativeSubtitleLabelFrame = frameOfViewInWindowsCoordinateSystem(fromVC.subtitleLabel)
        let destinationSubtitleLabelFrame = frameOfViewInWindowsCoordinateSystem(toVC.subtitleLabel)
        destinationSubtitleLabel.frame = relativeSubtitleLabelFrame
        containerView.addSubview(destinationSubtitleLabel)
        
        UIView.animate(withDuration: duration, animations: {
            destinationVinylDisk.frame = destinationVinylDiskFrame
            destinationTitleLabel.frame = destinationTitleLabelFrame
            destinationSubtitleLabel.frame = destinationSubtitleLabelFrame
            fromVC.view.alpha = 0
        }) { (_) in
            destinationVinylDisk.removeFromSuperview()
            destinationTitleLabel.removeFromSuperview()
            destinationSubtitleLabel.removeFromSuperview()
            transitionContext.completeTransition(true)
            fromVC.vinylDisk.alpha = 1
            fromVC.titleLabel.alpha = 1
            fromVC.subtitleLabel.alpha = 1
            fromVC.view.alpha = 1
            toVC.vinylDisk.alpha = 1
            toVC.titleLabel.alpha = 1
            toVC.subtitleLabel.alpha = 1
        }
    }
}
