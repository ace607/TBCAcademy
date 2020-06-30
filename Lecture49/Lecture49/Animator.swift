//
//  Animator.swift
//  Lecture49
//
//  Created by Admin on 6/30/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    var duration = 0.2
    var presenting = true
    var originFrame = CGRect.zero
    

    var dismissCompletion: (() -> Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let treeView = presenting ? toView : transitionContext.view(forKey: .from)!
        
        let initialFrame = presenting ? originFrame : treeView.frame
        let finalFrame = presenting ? treeView.frame : originFrame
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        
        if presenting {
          treeView.transform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
            treeView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
          treeView.clipsToBounds = true
        }

        treeView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(treeView)
        
       
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
            treeView.transform = self.presenting ? .identity : CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
            treeView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            treeView.layer.cornerRadius = 30
        }) { (f) in
//            if !self.presenting {
                transitionContext.completeTransition(true)
//            }
            
            if !self.presenting {
                self.dismissCompletion?()
            }
        }


        
    }

    private func setRadius(treeView: UIView, hasRadius: Bool) {
      treeView.layer.cornerRadius = hasRadius ? 20.0 : 0.0
    }
    
}
