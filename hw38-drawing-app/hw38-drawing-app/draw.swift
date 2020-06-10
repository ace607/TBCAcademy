//
//  draw.swift
//  hw38-drawing-app
//
//  Created by Admin on 6/10/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation
import UIKit

class DrawView: UIView {
    
    var lines = [[CGPoint]]()
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        
        let pathLayer = CAShapeLayer()
        
        pathLayer.strokeColor = UIColor(red: 41/255, green: 62/255, blue: 213/255, alpha: 1).cgColor
        pathLayer.lineWidth = 5
        pathLayer.fillColor = UIColor.white.cgColor

        
        lines.forEach { (line) in
            for (index, point) in line.enumerated() {
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
        }
        
        pathLayer.path = path.cgPath
        self.layer.addSublayer(pathLayer)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: nil)
        
        guard var lastLine = lines.popLast() else {return}
        lastLine.append(location)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}
