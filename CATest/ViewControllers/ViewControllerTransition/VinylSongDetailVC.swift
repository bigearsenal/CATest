//
//  VinylSongDetailVC.swift
//  CATest
//
//  Created by Chung Tran on 9/3/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class VinylSongDetailVC: VinylDiskVC {
    lazy var closeButton = UIButton(label: "close", textColor: .blue)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(closeButton)
        closeButton.autoPinToTopRightCornerOfSuperview()
        closeButton.addTarget(self, action: #selector(closeButtonDidTouch), for: .touchUpInside)
        
        vinylDisk.autoSetDimensions(to: CGSize(width: 300, height: 300))
        vinylDisk.layer.cornerRadius = 150
        
        let stackView = UIStackView(axis: .vertical, spacing: 20, alignment: .center, distribution: .fill)
        stackView.addArrangedSubview(vinylDisk)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        titleLabel.font = .boldSystemFont(ofSize: 30)
        subtitleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        view.addSubview(stackView)
        stackView.autoCenterInSuperview()
        
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rotateVinylDisk()
    }
    
    @objc func closeButtonDidTouch() {
        dismiss(animated: true, completion: nil)
    }
}
