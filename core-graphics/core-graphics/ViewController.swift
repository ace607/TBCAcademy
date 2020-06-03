//
//  ViewController.swift
//  core-graphics
//
//  Created by Admin on 6/3/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let shapeView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    var viewHeight: NSLayoutConstraint!
    var viewWidth: NSLayoutConstraint!
    var viewX: NSLayoutConstraint!
    var viewY: NSLayoutConstraint!
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(shapeView)
        
        viewWidth = NSLayoutConstraint(item: shapeView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.width - 60)
        viewHeight = NSLayoutConstraint(item: shapeView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        
        viewX = NSLayoutConstraint(item: shapeView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 30)
        
        viewY = NSLayoutConstraint(item: shapeView, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 30)
        self.view.addConstraint(viewWidth)
        self.view.addConstraint(viewHeight)
        self.view.addConstraint(viewX)
        self.view.addConstraint(viewY)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawShape()
        
    }

    func drawShape() {
        
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: viewWidth.constant, height: viewHeight.constant))
        
        let image = renderer.image { (ctx) in
            let square = CGRect(x: 0, y: 0, width: viewWidth.constant, height: viewHeight.constant)
            
            ctx.cgContext.setFillColor(UIColor(red: 250/255, green: 233/255, blue: 51/255, alpha: 1).cgColor)
            ctx.cgContext.setStrokeColor(UIColor(red: 106/255, green: 233/255, blue: 194/255, alpha: 1).cgColor)
            
            
            ctx.cgContext.setLineWidth(50)
            
            ctx.cgContext.addRect(square)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        shapeView.image = image
    }

}

