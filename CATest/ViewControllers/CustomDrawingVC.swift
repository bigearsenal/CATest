//
//  CustomDrawingVC.swift
//  CATest
//
//  Created by Chung Tran on 9/1/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class CustomDrawingView: UIView {
    lazy var path: UIBezierPath = {
        let path = UIBezierPath()
        path.lineJoinStyle = .round
        path.lineCapStyle = .round
        path.lineWidth = 5
        return path
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        path.move(to: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        path.addLine(to: point)
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.clear.setFill()
        UIColor.red.setStroke()
        path.stroke()
    }
}

class CustomDrawingVC: UIViewController {
    // NOTE: background = UIColor.clearColor() was the reason why touchesBegan was not called. Its obviously not called on transparent elements.
    lazy var drawingView = CustomDrawingView(backgroundColor: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(drawingView)
        drawingView.autoPinEdgesToSuperviewEdges()
        
        drawingView.isUserInteractionEnabled = true
        
    }
}
