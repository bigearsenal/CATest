//
//  ParticleEmittersVC.swift
//  CATest
//
//  Created by Chung Tran on 9/5/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class ParticleEmittersVC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.contents = UIImage(named: "bg-snowy")!.cgImage
        
        let rect = CGRect(x: 0.0, y: 100.0, width: view.bounds.width, height: 50.0)
        let emitter = CAEmitterLayer()
        emitter.frame = rect
        view.layer.addSublayer(emitter)
        
        emitter.emitterShape = .rectangle
        
        emitter.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2)
        emitter.emitterSize = rect.size
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "flake3")?.cgImage
        emitterCell.birthRate = 20
        emitterCell.lifetime = 3.5
        emitterCell.yAcceleration = 70.0
        emitterCell.xAcceleration = 10.0
        emitterCell.velocity = 20.0
        emitterCell.velocityRange = 200.0
        emitterCell.emissionLongitude = .pi * -0.5
        emitterCell.emissionRange = .pi * 0.5
        emitterCell.redRange = 0.3
        emitterCell.greenRange = 0.3
        emitterCell.blueRange = 0.3
        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.8
        emitter.emitterCells = [emitterCell]
        
    }
}
