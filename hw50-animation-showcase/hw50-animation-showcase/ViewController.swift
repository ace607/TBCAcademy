//
//  ViewController.swift
//  hw50-animation-showcase
//
//  Created by Admin on 7/1/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var shape: UIView!
    
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var delaySlider: UISlider!
    
    
    @IBOutlet weak var optionsBtn: UIButton!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var optionsViewBottom: NSLayoutConstraint!
    
    var optionsHidden = true
    
    
    var squareRadius = CGFloat()
    var circleRadius = CGFloat()
    
    var isSquare = true
    
    var animationType: AnimationType = .flipX
    var animationOption: AnimationOption = .curveEaseIn
    
    var layer = CALayer()
    
    // ************** OPTION OUTLETS
    
    // Labels
    @IBOutlet weak var dampingLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var rotateLabel: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var scaleLabel: UILabel!
    
    // Sliders
    @IBOutlet weak var dampingSlider: UISlider!
    @IBOutlet weak var velocitySlider: UISlider!
    @IBOutlet weak var rotateSlider: UISlider!
    @IBOutlet weak var xSlider: UISlider!
    @IBOutlet weak var ySlider: UISlider!
    @IBOutlet weak var scaleSlider: UISlider!
    
    
    // ORIGINAL FRAME
    
    var x = CGFloat()
    var y = CGFloat()
    var scaleX = 1
    var scaleY = 1
    var rotate = 0
    
    // OPTION OUTLETS **************
    
    
    // Animation Type and Option Pickers
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var optionPicker: UIPickerView!
    
    var typePickerData = [
        "FlipX",
        "FlipY",
        "Morph",
        "Shake",
        "Swing"
    ]
    
    
    var optionsPickerData = [
        "curveEaseIn",
        "curveEaseOut",
        "curveEaseInOut",
        "curveLinear"
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        squareRadius = 20
        circleRadius = shape.frame.height/2
        
        layer = shape.layer
        x = shape.frame.origin.x
        y = shape.frame.origin.y
        
        typePicker.delegate = self
        typePicker.dataSource = self
        optionPicker.delegate = self
        optionPicker.dataSource = self
        
        optionsViewBottom.constant -= 250
        
        
        shape.layer.cornerRadius = squareRadius
        
    }
    
    
    @IBAction func startAnimation(_ sender: UIButton) {
        animate()
        animateTransform()
    }
    
    private func animateTransform() {
        
        switch self.animationType {
        case .flipX:
            let transition = CATransition()
            transition.startProgress = delaySlider.value
            transition.endProgress = delaySlider.value + durationSlider.value
            transition.type = CATransitionType(rawValue: "flip");
            transition.subtype = CATransitionSubtype(rawValue: "fromRight");
            transition.duration = CFTimeInterval(durationSlider.value)
            transition.repeatCount = 1
            layer.add(transition, forKey: " ")
            
        case .flipY:
            let transition = CATransition()
            transition.startProgress = delaySlider.value
            transition.endProgress = delaySlider.value + durationSlider.value
            transition.type = CATransitionType(rawValue: "flip");
            transition.subtype = CATransitionSubtype(rawValue: "fromTop");
            transition.duration = CFTimeInterval(durationSlider.value)
            transition.repeatCount = 1
            layer.add(transition, forKey: " ")
            
        case .morph:
            let animation = CABasicAnimation(keyPath: "cornerRadius")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.isRemovedOnCompletion = false
            animation.fromValue = layer.cornerRadius
            animation.toValue = layer.bounds.width/2
            animation.duration = CFTimeInterval(durationSlider.value)/4
            animation.autoreverses = true
            animation.repeatCount = 4
            layer.add(animation, forKey: "cornerRadius")
            
        case .shake:
            let midX = shape.center.x
            let midY = shape.center.y
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = CFTimeInterval(durationSlider.value)/4
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = CGPoint(x: midX - 10, y: midY)
            animation.toValue = CGPoint(x: midX + 10, y: midY)
            shape.layer.add(animation, forKey: "position")
            
        case .swing:
            let animation = CAKeyframeAnimation()
            animation.keyPath = "transform.rotation"
            animation.values = [0, 0.3*0.2, -0.3*0.2, 0.3*0.2, 0]
            animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            animation.duration = CFTimeInterval(durationSlider.value)/4
            animation.isAdditive = true
            animation.repeatCount = 4
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(0.5)
            layer.add(animation, forKey: "swing")
            
            
            
        }
    }
    
    private func animate() {
        
        var currentAnimationOption = UIView.AnimationOptions.Element()
        
        
        switch animationOption {
        case .curveEaseIn:
            currentAnimationOption = .curveEaseIn
        case .curveEaseOut:
            currentAnimationOption = .curveEaseOut
        case .curveEaseInOut:
            currentAnimationOption = .curveEaseInOut
        case .curveLinear:
            currentAnimationOption = .curveLinear
        }
        
        UIView.animate(withDuration: TimeInterval(durationSlider.value),
                       delay: TimeInterval(delaySlider.value),
                       usingSpringWithDamping: CGFloat(dampingSlider.value),
                       initialSpringVelocity: CGFloat(velocitySlider.value),
                       options: [currentAnimationOption], animations: {
                        
                        let v = self.shape!
                        
                        let scale = CGAffineTransform(scaleX: CGFloat(self.scaleSlider.value), y: CGFloat(self.scaleSlider.value))
                        let rotate = CGAffineTransform(rotationAngle: CGFloat(self.rotateSlider.value) * 180)
                        let translate = CGAffineTransform(translationX: CGFloat(self.xSlider.value), y: CGFloat(self.ySlider.value))
                        let translateAndScale = translate.concatenating(scale)
                        v.transform = rotate.concatenating(translateAndScale)
                        
                        
        }) { (f) in
            UIView.animate(withDuration: TimeInterval(self.durationSlider.value),
                           delay: TimeInterval(self.delaySlider.value),
                           usingSpringWithDamping: CGFloat(self.dampingSlider.value),
                           initialSpringVelocity: CGFloat(self.velocitySlider.value),
                           options: [currentAnimationOption], animations: {
                            
                            self.shape.transform = .identity
                            print(self.shape.transform.isIdentity)
            })
        }
        
    }
    
    @IBAction func changeShape(_ sender: UIButton) {
        isSquare = !isSquare
        sender.setImage(UIImage(systemName: !self.isSquare ?  "square.fill" : "circle.fill"), for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.shape.layer.cornerRadius = self.isSquare ? self.squareRadius : self.circleRadius
        }
    }
    
    @IBAction func showOptions(_ sender: Any) {
        optionsViewBottom.constant += self.optionsHidden ? 250 : -250
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.15, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { (f) in
            self.optionsHidden = !self.optionsHidden
        }
    }
    
    
    @IBAction func durationChanged(_ sender: UISlider) {
        durationLabel.text = "Duration: \(String(format: "%.1f", sender.value))"
    }
    
    @IBAction func delayChanged(_ sender: UISlider) {
        delayLabel.text = "Delay: \(String(format: "%.1f", sender.value))"
    }
    
    
    
    // OPTION ACTIONS
    
    @IBAction func changeDamping(_ sender: UISlider) {
        dampingLabel.text = "Damping: \(String(format: "%.1f", sender.value))"
    }
    
    @IBAction func changeVelocity(_ sender: UISlider) {
        velocityLabel.text = "Velocity: \(String(format: "%.1f", sender.value))"
    }
    
    @IBAction func changeRotate(_ sender: UISlider) {
        rotateLabel.text = "Rotate: \(String(format: "%.1f", sender.value))"
    }
    
    @IBAction func changeX(_ sender: UISlider) {
        xLabel.text = "x: \(String(format: "%.1f", sender.value))"
    }
    
    @IBAction func changeY(_ sender: UISlider) {
        yLabel.text = "y: \(String(format: "%.1f", sender.value))"
    }
    
    @IBAction func changeScale(_ sender: UISlider) {
        scaleLabel.text = "Scale: \(String(format: "%.1f", sender.value))"
    }
    
}

enum AnimationType {
    case shake
    case morph
    case flipX
    case flipY
    case swing
}

enum AnimationOption {
    case curveEaseIn
    case curveEaseOut
    case curveEaseInOut
    case curveLinear
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return typePickerData.count
        } else if pickerView.tag == 1 {
            return optionsPickerData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return typePickerData[row]
        } else if pickerView.tag == 1 {
            return optionsPickerData[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            switch row {
            case 0:
                animationType = .flipX
            case 1:
                animationType = .flipY
            case 2:
                animationType = .morph
            case 3:
                animationType = .shake
            case 4:
                animationType = .swing
            default:
                print("n")
            }
        } else if pickerView.tag == 1 {
            switch row {
            case 0:
                animationOption = .curveEaseIn
            case 1:
                animationOption = .curveEaseOut
            case 2:
                animationOption = .curveEaseInOut
            case 3:
                animationOption = .curveLinear
            default:
                print("n")
            }
        }
    }
    
}
