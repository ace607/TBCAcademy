//
//  ViewController.swift
//  hw52
//
//  Created by Admin on 6/30/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var midViewX = CGFloat()
    var midViewY = CGFloat()

    var ballPath = UIBezierPath()
    var shapeLayer2 = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        midViewX = view.frame.midX
        midViewY = view.frame.midY
        setupCircles()
        
        let dragBall = UIPanGestureRecognizer(target: self, action:#selector(dragBall(recognizer:)))
        view.addGestureRecognizer(dragBall)
    }
    
    
    func setupCircles() {
        
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: midViewX,y: midViewY), radius: CGFloat(120), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 50.0
        
        view.layer.addSublayer(shapeLayer)
        

        
        let angleBall: Double = 0
        let angleBallAfterCalculate: CGFloat = CGFloat(angleBall*Double.pi/180) - CGFloat(Double.pi/2)
        let ballX = midViewX + cos(angleBallAfterCalculate)*120
        let ballY = midViewY + sin(angleBallAfterCalculate)*120
        ballPath = UIBezierPath(arcCenter: CGPoint(x: ballX,y: ballY), radius: CGFloat(25), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        shapeLayer2.path = ballPath.cgPath
        shapeLayer2.fillColor = UIColor.systemIndigo.cgColor
        shapeLayer2.strokeColor = UIColor.clear.cgColor
        shapeLayer2.lineWidth = 50
        view.layer.addSublayer(shapeLayer2)
        
        
    }
    
    @objc func dragBall(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.location(in: self.view);
        let ballX = Double(point.x)
        let ballY = Double(point.y)
        let midViewXDouble = Double(midViewX)
        let midViewYDouble = Double(midViewY)
        let angleX = (ballX - midViewXDouble)
        let angleY = (ballY - midViewYDouble)
        
        let angle = atan2(angleY, angleX)
        let ballX2 = midViewXDouble + cos(angle)*120
        let ballY2 = midViewYDouble + sin(angle)*120
        ballPath = UIBezierPath(arcCenter: CGPoint(x: ballX2,y: ballY2), radius: CGFloat(25), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        shapeLayer2.path = ballPath.cgPath
    }
    
}

