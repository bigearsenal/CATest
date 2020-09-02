//
//  CubeTransitionVC.swift
//  CATest
//
//  Created by Chung Tran on 9/2/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    enum CubeTransitionDirection: Int {
        case up = 1, down = -1
    }
    
    var copied: UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = font
        label.textColor = textColor
        label.shadowColor = shadowColor
        label.shadowOffset = shadowOffset
        label.textAlignment = textAlignment
        label.lineBreakMode = lineBreakMode
        label.attributedText = attributedText
        label.highlightedTextColor = highlightedTextColor
        label.isHighlighted = isHighlighted
        label.isUserInteractionEnabled = isUserInteractionEnabled
        label.isEnabled = isEnabled
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        label.baselineAdjustment = baselineAdjustment
        label.minimumScaleFactor = minimumScaleFactor
        label.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
        label.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        label.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        return label
    }
    
    func cubeTranstion(to text: String, direction: CubeTransitionDirection = .down, duration: TimeInterval = 0.25, completion: ((Bool) -> Void)? = nil) {
        let auxLabel = copied
        auxLabel.translatesAutoresizingMaskIntoConstraints = true
        auxLabel.text = text
        auxLabel.sizeToFit()
        auxLabel.center = center
        
        let offset = CGFloat(direction.rawValue) * frame.size.height / 2
        auxLabel.transform = CGAffineTransform(scaleX: 1.0, y: 0.1)
            .concatenating(CGAffineTransform(translationX: 0, y: offset))
        superview?.addSubview(auxLabel)
        
        UIView.animate(withDuration: duration, animations: {
            auxLabel.transform = .identity
            self.transform = CGAffineTransform(scaleX: 1.0, y: 0.1)
                .concatenating(CGAffineTransform(translationX: 0.0, y: -offset) )
        }) { (completed) in
            self.text = text
            self.transform = .identity
            auxLabel.removeFromSuperview()
            completion?(completed)
        }
    }
}

class CubeTransitionVC: ViewAnimationVC {
    lazy var label = UILabel(text: "initial", textSize: 30, weight: .bold, textColor: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.autoCenterInSuperview()
    }
    
    override func resetState() {
        label.text = "initial"
    }
    
    override func animate() {
        label.cubeTranstion(to: "modified", direction: .down, duration: 0.5) { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.label.cubeTranstion(to: "initial", direction: .up, duration: 0.5, completion: nil)
            }
        }
    }
}
