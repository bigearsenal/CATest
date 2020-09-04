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
        animation.isRemovedOnCompletion = false
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
        HeroAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = HeroAnimator()
        animator.isPresenting = false
        return animator
    }
}

class HeroAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.3
    
    var isPresenting = true
    
    func vinylDiskVC(unwrappedFromPosibleNavigationController toVC: UIViewController) -> VinylDiskVC? {
        if let nc = toVC as? UINavigationController {
            return nc.topViewController as? VinylDiskVC
        }
        return toVC as? VinylDiskVC
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = isPresenting ?
            transitionContext.viewController(forKey: .from) as? UINavigationController :
            transitionContext.viewController(forKey: .from) as? VinylSongDetailVC,
        let toVC = isPresenting ?
            transitionContext.viewController(forKey: .to) as? VinylSongDetailVC :
            transitionContext.viewController(forKey: .to) as? UINavigationController
        else {
            transitionContext.completeTransition(true)
            return
        }
        // Prepare
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.sendSubviewToBack(toVC.view)
        
        guard let destinationVinylDisk = vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)?.vinylDisk.snapshotView(afterScreenUpdates: true),
            let destinationTitleLabel = vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)?.titleLabel.snapshotView(afterScreenUpdates: true),
            let destinationSubtitleLabel = vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)?.subtitleLabel.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        vinylDiskVC(unwrappedFromPosibleNavigationController: fromVC)?.vinylDisk.alpha = 0
        vinylDiskVC(unwrappedFromPosibleNavigationController: fromVC)?.titleLabel.alpha = 0
        vinylDiskVC(unwrappedFromPosibleNavigationController: fromVC)?.subtitleLabel.alpha = 0
        vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)?.vinylDisk.alpha = 0
        vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)?.titleLabel.alpha = 0
        vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)?.subtitleLabel.alpha = 0
        
        let relativeVinylDiskFrame = frameOfViewInWindowsCoordinateSystem(vinylDiskVC(unwrappedFromPosibleNavigationController: fromVC)!.vinylDisk)
        let destinationVinylDiskFrame = frameOfViewInWindowsCoordinateSystem(vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)!.vinylDisk)
        destinationVinylDisk.frame = relativeVinylDiskFrame
        containerView.addSubview(destinationVinylDisk)
        
        let relativeTitleLabelFrame = frameOfViewInWindowsCoordinateSystem(vinylDiskVC(unwrappedFromPosibleNavigationController: fromVC)!.titleLabel)
        let destinationTitleLabelFrame = frameOfViewInWindowsCoordinateSystem(vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)!.titleLabel)
        destinationTitleLabel.frame = relativeTitleLabelFrame
        containerView.addSubview(destinationTitleLabel)
        
        let relativeSubtitleLabelFrame = frameOfViewInWindowsCoordinateSystem(vinylDiskVC(unwrappedFromPosibleNavigationController: fromVC)!.subtitleLabel)
        let destinationSubtitleLabelFrame = frameOfViewInWindowsCoordinateSystem(vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)!.subtitleLabel)
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
            self.vinylDiskVC(unwrappedFromPosibleNavigationController: fromVC)?.vinylDisk.alpha = 1
            self.vinylDiskVC(unwrappedFromPosibleNavigationController: fromVC)?.titleLabel.alpha = 1
            self.vinylDiskVC(unwrappedFromPosibleNavigationController: fromVC)?.subtitleLabel.alpha = 1
            fromVC.view.alpha = 1
            self.vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)?.vinylDisk.alpha = 1
            self.vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)?.titleLabel.alpha = 1
            self.vinylDiskVC(unwrappedFromPosibleNavigationController: toVC)?.subtitleLabel.alpha = 1
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
