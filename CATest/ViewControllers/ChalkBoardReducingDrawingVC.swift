//
//  ChalkBoardReducingDrawingVC.swift
//  CATest
//
//  Created by Chung Tran on 9/1/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class ChalkBoardViewReducingDrawing: ChalkBoardView {
    override func addBrushStroke(at point: CGPoint) {
        strokes.append(point)
        setNeedsDisplay(brushRect(for: point))
    }
    
    override func draw(_ rect: CGRect) {
        for point in strokes where rect.intersects(brushRect(for: point)) {
             UIImage(named: "Chalk")?.draw(in: brushRect(for: point))
        }
    }
}

class ChalkBoardReducingDrawingVC: CustomDrawingVC<ChalkBoardViewReducingDrawing> {
    override func viewDidLoad() {
        super.viewDidLoad()
        drawingView.backgroundColor = .black
    }
}
