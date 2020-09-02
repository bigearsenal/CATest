//
//  ChalkBoardVC.swift
//  CATest
//
//  Created by Chung Tran on 9/1/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class ChalkBoardView: UIView {
    lazy var strokes = [CGPoint]()
    let brushSize: CGFloat = 32
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        addBrushStroke(at: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        addBrushStroke(at: point)
    }
    
    func addBrushStroke(at point: CGPoint) {
        strokes.append(point)
        
        setNeedsDisplay()
    }
    
    func brushRect(for point: CGPoint) -> CGRect {
        CGRect(x: point.x - brushSize / 2, y: point.y - brushSize / 2, width: brushSize, height: brushSize)
    }
    
    override func draw(_ rect: CGRect) {
        for point in strokes {
            UIImage(named: "Chalk")?.draw(in: brushRect(for: point))
        }
    }
}

class ChalkBoardVC: CustomDrawingVC<ChalkBoardView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        drawingView.backgroundColor = .black
    }
}


