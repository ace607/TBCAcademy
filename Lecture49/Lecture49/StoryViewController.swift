//
//  StoryViewController.swift
//  Lecture49
//
//  Created by Admin on 6/30/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    
    @IBOutlet weak var storyImg: UIImageView!
    
    var imgs = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3"),
        UIImage(named: "4"),
        UIImage(named: "5"),
        UIImage(named: "6"),
        UIImage(named: "7"),
        UIImage(named: "8")
    ]
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyImg.image = imgs[selectedIndex]

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                previousStory()
            case .down:
                exitStory()
            case .left:
                nextStory()
            default:
                break
            }
        }
    }
    
    private func nextStory() {
        if selectedIndex != imgs.count - 1 {
            selectedIndex += 1
            let transition = CATransition()
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            storyImg.layer.add(transition, forKey: nil)
            self.storyImg.image = self.imgs[self.selectedIndex]
        }
    }
    
    private func previousStory() {
        if selectedIndex != 0 {
            selectedIndex -= 1
            let transition = CATransition()
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            storyImg.layer.add(transition, forKey: nil)
            self.storyImg.image = self.imgs[self.selectedIndex]
        }
    }
    
    private func exitStory() {
        dismiss(animated: true)
    }

}
