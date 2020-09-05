//
//  ExpandableListVC.swift
//  CATest
//
//  Created by Chung Tran on 9/5/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class ExpandableListVC: BaseViewController {
    lazy var showMoreButton = UIButton(label: "show more", textColor: .black)
    lazy var headerView: UIView = {
        let view = UIView(height: 30, backgroundColor: UIColor.white.withAlphaComponent(0.8))
        view.addSubview(showMoreButton)
        showMoreButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        showMoreButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        return view
    }()
    lazy var listViewStackView = UIStackView(axis: .vertical, spacing: 10, alignment: .fill, distribution: .fillEqually)
    lazy var firstLineStackView = UIStackView(axis: .horizontal, spacing: 10, alignment: .fill, distribution: .fillEqually)
    lazy var secondLineStackView = UIStackView(axis: .horizontal, spacing: 10, alignment: .fill, distribution: .fillEqually)
    var expanded = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listView = UIView(backgroundColor: UIColor.white.withAlphaComponent(0.7))
        
        listViewStackView.addArrangedSubview(firstLineStackView)
        listViewStackView.addArrangedSubview(secondLineStackView)
        
        listView.addSubview(listViewStackView)
        listViewStackView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        for _ in 0..<4 {
            firstLineStackView.addArrangedSubview(createCell())
            secondLineStackView.addArrangedSubview(createCell())
        }
        
        let stackView = UIStackView(axis: .vertical, spacing: 0, alignment: .fill, distribution: .fill)
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        view.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
        
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(listView)
        
        reloadData()
        
        showMoreButton.addTarget(self, action: #selector(buttonShowMoreDidTouch), for: .touchUpInside)
    }
    
    func reloadData() {
        secondLineStackView.isHidden = !expanded
    }
    
    private func createCell() -> UIImageView {
        let imageView = UIImageView(cornerRadius: 10, imageNamed: "dog")
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        return imageView
    }
    
    @objc func buttonShowMoreDidTouch() {
        expanded.toggle()
        
        let listAnimation = {
//            self.secondLineStackView.alpha = self.expanded ? 1: 0
            self.secondLineStackView.transform = CGAffineTransform(scaleX: 1, y: self.expanded ? 1 : 0)
            self.reloadData()
        }
        
        let textTransition = {
            UIView.transition(with: self.showMoreButton, duration: 0.3, animations: {
                self.showMoreButton.setTitle(self.expanded ? "show less": "show more", for: .normal)
            })
        }
        
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
        animator.addAnimations(listAnimation)
        animator.addAnimations(textTransition)
        animator.startAnimation()
    }
}
