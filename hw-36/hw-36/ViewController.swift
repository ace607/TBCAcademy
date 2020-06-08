//
//  ViewController.swift
//  hw-36
//
//  Created by Admin on 6/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pagesCollection: UICollectionView!
    
    var pages = [Page]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pagesCollection.delegate = self
        pagesCollection.dataSource = self
        
        pagesCollection.isPagingEnabled = true
        
        setUpPages()
        
    }
    
    
    func setUpPages() {
        let page1 = Page(imgName: "first_page", title: "Online shopping", info: "Women Fashion Shopping Online - Shop from a huge range of latest women clothing, shoes, makeup Kits, Watches, footwear and more for women at best price")
        let page2 = Page(imgName: "second_page", title: "Add to cart", info: "Add to cart button works on product pages. The customizations in this section  compatible with dynamic checkout buttons")
        let page3 = Page(imgName: "third_page", title: "Payment Successful", info: "Your payment has been successfully completed. You will receive a confirmation email within a few minutes.")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
    }
    

    @IBAction func onSkip(_ sender: UIButton) {
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onNext(_ sender: UIButton) {
        if pageControl.currentPage == pages.count - 1 {
            showAlert(title: "Warning", message: "This is the last page")
        } else {
            pagesCollection.scrollToItem(at: IndexPath(item: pageControl.currentPage > pages.count ? 0 : pageControl.currentPage + 1, section: 0), at: .centeredHorizontally, animated: true)

            pageControl.currentPage += pageControl.currentPage == pages.count - 1 ? 0 : 1
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentIndex = Int(targetContentOffset.pointee.x / self.pagesCollection.frame.size.width)
        
        pageControl.currentPage = currentIndex
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pagesCollection.dequeueReusableCell(withReuseIdentifier: "page_cell", for: indexPath) as! PageCollectionViewCell
        
        cell.setupCell(for: pages[indexPath.row])
        
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
