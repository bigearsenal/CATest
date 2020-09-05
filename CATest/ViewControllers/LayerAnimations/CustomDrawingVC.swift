//
//  CustomDrawingVC.swift
//  CATest
//
//  Created by Chung Tran on 9/1/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class PathStrokeDrawingView: UIView {
    lazy var path: UIBezierPath = {
        let path = UIBezierPath()
        path.lineJoinStyle = .round
        path.lineCapStyle = .round
        path.lineWidth = 5
        return path
    }()
    
    var shouldUpdateDisplayAfterTouchesMoved: Bool {true}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        path.move(to: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        path.addLine(to: point)
        if shouldUpdateDisplayAfterTouchesMoved {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.clear.setFill()
        UIColor.red.setStroke()
        path.stroke()
    }
}

class LayerDrawingView: PathStrokeDrawingView {
    override var shouldUpdateDisplayAfterTouchesMoved: Bool {false}
    
    override class var layerClass: AnyClass {
        get {CAShapeLayer.self}
    }
    
    override func draw(_ rect: CGRect) {
        // do nothing
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        let layer = self.layer as! CAShapeLayer
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineJoin = .round
        layer.lineCap = .round
        layer.lineWidth = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        (layer as! CAShapeLayer).path = path.cgPath
    }
}

class CustomDrawingVC<T: UIView>: BaseViewController {
    // NOTE: background = UIColor.clearColor() was the reason why touchesBegan was not called. Its obviously not called on transparent elements.
    lazy var drawingView: T = {
        let view = T(frame: .zero)
        view.backgroundColor = .white
        view.configureForAutoLayout()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(drawingView)
        drawingView.autoPinEdgesToSuperviewEdges()
        
        drawingView.isUserInteractionEnabled = true
        
    }
}
