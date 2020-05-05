//
//  categoryItemsViewController.swift
//  photo-gallery
//
//  Created by Admin on 5/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class categoryItemsViewController: UIViewController {
    
    var selectedCategory = 0
    
    var categoryPhotos = [String]()

    
    lazy var categoryItems: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(categoryCell.self, forCellWithReuseIdentifier: "category-item-cell")
        collection.backgroundColor = .white
        
        return collection
        
    }()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(categoryItems)
        
        NSLayoutConstraint.activate([
            categoryItems.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryItems.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryItems.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryItems.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension categoryItemsViewController: UICollectionViewDelegate {
    
}

extension categoryItemsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category-item-cell", for: indexPath) as! categoryCell
        
        cell.photo.image = UIImage(named: categoryPhotos[indexPath.row])
        
        return cell
    }
}

extension categoryItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.frame.width / 2) - 40
        
        return CGSize(width: itemWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
