//
//  ViewController.swift
//  views-programmatically
//
//  Created by Admin on 5/4/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedView = 0
    
    let view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemIndigo
        return view
    }()
    
    var view1Height: NSLayoutConstraint!
    var view1Width: NSLayoutConstraint!
    var view1X: NSLayoutConstraint!
    var view1Y: NSLayoutConstraint!
    
    
    let view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }()
    
    
    var view2Height: NSLayoutConstraint!
    var view2Width: NSLayoutConstraint!
    var view2X: NSLayoutConstraint!
    var view2Y: NSLayoutConstraint!
    
    let widthField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.placeholder = "Width"
        return textField
    }()
    
    
    let heightField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.placeholder = "Height"
        return textField
    }()
    
    let changeSizeBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(onChange), for: .touchUpInside)
        return button
    }()
    
    
    let moveToTopBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(moveToTop), for: .touchUpInside)
        return button
    }()
    
    
    let moveToLeftBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(moveToLeft), for: .touchUpInside)
        return button
    }()
    
    let moveToRightBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(moveToRight), for: .touchUpInside)
        return button
    }()
    
    let moveToBottomBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(moveToBottom), for: .touchUpInside)
        return button
    }()
    
    let sizeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(onSliderChange), for: .valueChanged)
        slider.minimumValue = 0
        slider.maximumValue = 2
        slider.value = 1
        return slider
    }()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(view1)
        view.addSubview(view2)
        
        view.addSubview(widthField)
        view.addSubview(heightField)
        
        view.addSubview(changeSizeBtn)
        
        view.addSubview(moveToTopBtn)
        view.addSubview(moveToLeftBtn)
        view.addSubview(moveToRightBtn)
        view.addSubview(moveToBottomBtn)
        
        view.addSubview(sizeSlider)
        
        view1Width = NSLayoutConstraint(item: view1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        view1Height = NSLayoutConstraint(item: view1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        
        view1X = NSLayoutConstraint(item: view1, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: -(self.view.frame.midX/2))
        
        view1Y = NSLayoutConstraint(item: view1, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 30)
        self.view.addConstraint(view1Width)
        self.view.addConstraint(view1Height)
        self.view.addConstraint(view1X)
        self.view.addConstraint(view1Y)
        
        view2Width = NSLayoutConstraint(item: view2, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        view2Height = NSLayoutConstraint(item: view2, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        view2X = NSLayoutConstraint(item: view2, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: self.view.frame.midX/2)
        
        view2Y = NSLayoutConstraint(item: view2, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 30)
        self.view.addConstraint(view2Width)
        self.view.addConstraint(view2Height)
        self.view.addConstraint(view2X)
        self.view.addConstraint(view2Y)
        
        
        NSLayoutConstraint.activate([
            widthField.bottomAnchor.constraint(equalTo: moveToTopBtn.topAnchor, constant: -100),
            widthField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            widthField.widthAnchor.constraint(equalToConstant: (self.view.bounds.width - 90)/3),
            widthField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        NSLayoutConstraint.activate([
            heightField.topAnchor.constraint(equalTo: widthField.topAnchor, constant: 0),
            heightField.leadingAnchor.constraint(equalTo: widthField.trailingAnchor, constant: 15),
            heightField.widthAnchor.constraint(equalToConstant: (self.view.bounds.width - 90)/3),
            heightField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        NSLayoutConstraint.activate([
            changeSizeBtn.topAnchor.constraint(equalTo: heightField.topAnchor, constant: 0),
            changeSizeBtn.leadingAnchor.constraint(equalTo: heightField.trailingAnchor, constant: 15),
            changeSizeBtn.widthAnchor.constraint(equalToConstant: (self.view.bounds.width - 90)/3),
            changeSizeBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        NSLayoutConstraint.activate([
            moveToTopBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 90),
            moveToTopBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            moveToTopBtn.widthAnchor.constraint(equalToConstant: 50),
            moveToTopBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        NSLayoutConstraint.activate([
            moveToLeftBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            moveToLeftBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
            moveToLeftBtn.widthAnchor.constraint(equalToConstant: 50),
            moveToLeftBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            moveToRightBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            moveToRightBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
            moveToRightBtn.widthAnchor.constraint(equalToConstant: 50),
            moveToRightBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            moveToBottomBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 210),
            moveToBottomBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            moveToBottomBtn.widthAnchor.constraint(equalToConstant: 50),
            moveToBottomBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        NSLayoutConstraint.activate([
            sizeSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            sizeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sizeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            sizeSlider.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstSelected)))
        view2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondSelected)))
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    @objc func onChange() {
        print(#function)
        
        switch selectedView {
            case 0:
                showAlert(title: "Error", message: "Please, select a view.")
            case 1:
                if widthField.text == "" || heightField.text == ""  {
                    showAlert(title: "Error", message: "Please, fill all fields.")
                } else if Int(widthField.text!) == nil || Int(heightField.text!) == nil {
                    showAlert(title: "Error", message: "Please, enter integers.")
                } else {
                    view1Width.constant = CGFloat(Int(widthField.text!)!)
                    view1Height.constant = CGFloat(Int(heightField.text!)!)
                }
            case 2:
                if widthField.text == "" || heightField.text == ""  {
                    showAlert(title: "Error", message: "Please, fill all fields.")
                } else if Int(widthField.text!) == nil || Int(heightField.text!) == nil {
                    showAlert(title: "Error", message: "Please, enter integers.")
                } else {
                    view2Width.constant = CGFloat(Int(widthField.text!)!)
                    view2Height.constant = CGFloat(Int(heightField.text!)!)
                }
            default:
                print("")
        }
    }
    
    @objc func moveToTop() {
        switch selectedView {
            case 0:
                showAlert(title: "Error", message: "Please, select a view.")
            case 1:
                view1Y.constant -= 10
            case 2:
                view2Y.constant -= 10
            default:
                print("")
        }
    }
    
    @objc func moveToLeft() {
        switch selectedView {
            case 0:
                showAlert(title: "Error", message: "Please, select a view.")
            case 1:
                view1X.constant -= 10
            case 2:
                view2X.constant -= 10
            default:
                print("")
        }
    }
    
    @objc func moveToRight() {
        switch selectedView {
            case 0:
                showAlert(title: "Error", message: "Please, select a view.")
            case 1:
                view1X.constant += 10
            case 2:
                view2X.constant += 10
            default:
                print("")
        }
    }
    
    @objc func moveToBottom() {
        switch selectedView {
            case 0:
                showAlert(title: "Error", message: "Please, select a view.")
            case 1:
                view1Y.constant += 10
            case 2:
                view2Y.constant += 10
            default:
                print("")
        }
    }
    
    @objc func firstSelected() {
       selectedView = 1
    }
    
    @objc func secondSelected() {
       selectedView = 2
    }

    @objc func onSliderChange() {
        
    }
}

