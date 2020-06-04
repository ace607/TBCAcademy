//
//  ViewController.swift
//  taxi-app
//
//  Created by Admin on 6/4/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pageCollection: UICollectionView!
   
    @IBOutlet weak var pageController: UIStackView!
    @IBOutlet weak var dotOne: NSLayoutConstraint!
    @IBOutlet weak var dotTwo: NSLayoutConstraint!
    @IBOutlet weak var dotThree: NSLayoutConstraint!
    
    var pageData = [
       (image: "first-page", title: "Request Ride", info: "Request a ride get picked up by a nearby community driver", btn: "SKIP"),
       (image: "second-page", title: "Confirm Your Driver", info: "Huge Drivers network helps, find comfortable, safe and cheap ride", btn: "SKIP"),
       (image: "third-page", title: "Track Your Ride", info: "Know your driver in advance and be able to view current location in real time on the map", btn: "GET STARTED")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageCollection.delegate = self
        pageCollection.dataSource = self
        
        pageCollection.isPagingEnabled = true
        
        
        let dots = pageController.arrangedSubviews
        
        dots.forEach { (view) in
            view.layer.cornerRadius = 3
        }
        
        dotOne.constant = 26
        dotTwo.constant = 14
        dotThree.constant = 14
        dots[0].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 1)
        dots[1].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 0.2)
        dots[2].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 0.2)
    }

}


extension ViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentIndex = Int(targetContentOffset.pointee.x / self.pageCollection.frame.size.width)

        let dots = pageController.arrangedSubviews
        
        if currentIndex == 0 {
            dotOne.constant = 26
            dotTwo.constant = 14
            dotThree.constant = 14
            dots[0].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 1)
            dots[1].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 0.2)
            dots[2].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 0.2)
        } else if currentIndex == 1 {
            dotOne.constant = 14
            dotTwo.constant = 26
            dotThree.constant = 14
            dots[1].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 1)
            dots[0].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 0.2)
            dots[2].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 0.2)
        } else if currentIndex == 2 {
            dotOne.constant = 14
            dotTwo.constant = 14
            dotThree.constant = 26
            dots[2].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 1)
            dots[1].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 0.2)
            dots[0].backgroundColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 0.2)
        }
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pageCollection.dequeueReusableCell(withReuseIdentifier: "page_cell", for: indexPath) as! PageCollectionViewCell
        
        cell.pageImage.image = UIImage(named: pageData[indexPath.row].image)
        cell.pageTitle.text = pageData[indexPath.row].title
        cell.pageInfo.text = pageData[indexPath.row].info
        cell.pageBtn.setTitle(pageData[indexPath.row].btn, for: .normal)
        
        cell.pageBtn.addTextSpacing(spacing: 4)
        
        if indexPath.row == 2 {
            cell.pageBtn.layer.borderWidth = 2
            cell.pageBtn.layer.borderColor = UIColor(red: 29/255, green: 36/255, blue: 124/255, alpha: 1).cgColor
            cell.pageBtn.layer.cornerRadius = 6
        }
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.safeAreaLayoutGuide.layoutFrame.width
        let height = view.safeAreaLayoutGuide.layoutFrame.height
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension UIButton{
   func addTextSpacing(spacing: CGFloat){
       let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
    attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)! - 1))
       self.setAttributedTitle(attributedString, for: .normal)
   }
}
