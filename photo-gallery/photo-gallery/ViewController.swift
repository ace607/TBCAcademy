//
//  ViewController.swift
//  photo-gallery
//
//  Created by Admin on 5/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    let cars = ["car1", "car2", "car3", "car4"]
    let animals = ["animal1", "animal2", "animal3", "animal4"]
    let cities = ["city1", "city2", "city3", "city4"]
    let sports = ["sport1", "sport2", "sport3", "sport4"]
    
    var selectedCategory = 0
    
    lazy var photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        layout.scrollDirection = .horizontal
        collection.delegate = self
        collection.dataSource = self
        collection.register(photoCell.self, forCellWithReuseIdentifier: "photo-cell")
        collection.backgroundColor = .white
        
        return collection
        
    }()
    
    let viewPhoto: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(viewPhoto)
        view.addSubview(photoCollection)
        
        NSLayoutConstraint.activate([
            viewPhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            viewPhoto.bottomAnchor.constraint(equalTo: photoCollection.topAnchor, constant: -30),
            viewPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            photoCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photoCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoCollection.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewPhoto.image = UIImage(named: cars[0])
        
        viewPhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showCategories)))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_category_items" {
            if let categoryItemsVC = segue.destination as? categoryItemsViewController {
                categoryItemsVC.selectedCategory = selectedCategory
                
                switch selectedCategory {
                    case 0:
                        categoryItemsVC.categoryPhotos = cars
                    case 1:
                        categoryItemsVC.categoryPhotos = animals
                    case 2:
                        categoryItemsVC.categoryPhotos = cities
                    case 3:
                        categoryItemsVC.categoryPhotos = sports
                    default:
                        print("")
                }
            }
        }
    }
    
    @objc func showCategories() {
        performSegue(withIdentifier: "show_category_items", sender: nil)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row < cars.count {
            viewPhoto.image = UIImage(named: cars[indexPath.row])
            selectedCategory = 0
        } else if indexPath.row > (cars.count - 1) && indexPath.row < (cars.count + animals.count) {
            viewPhoto.image = UIImage(named: animals[indexPath.row - cars.count])
            selectedCategory = 1
        } else if indexPath.row > (cars.count + animals.count - 1) && indexPath.row < (cars.count + animals.count + cities.count) {
            viewPhoto.image = UIImage(named: cities[indexPath.row - cars.count - animals.count])
            selectedCategory = 2
        } else if indexPath.row > (cars.count + animals.count + cities.count - 1) && indexPath.row < (cars.count + animals.count + cities.count + sports.count) {
            viewPhoto.image = UIImage(named: sports[indexPath.row - cars.count - animals.count - cities.count])
            selectedCategory = 3
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars.count + animals.count + cities.count + sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo-cell", for: indexPath) as! photoCell
        
        if indexPath.row < cars.count {
            cell.photo.image = UIImage(named: cars[indexPath.row])
        } else if indexPath.row > (cars.count - 1) && indexPath.row < (cars.count + animals.count) {
            cell.photo.image = UIImage(named: animals[indexPath.row - cars.count])
        } else if indexPath.row > (cars.count + animals.count - 1) && indexPath.row < (cars.count + animals.count + cities.count) {
            cell.photo.image = UIImage(named: cities[indexPath.row - cars.count - animals.count])
        } else if indexPath.row > (cars.count + animals.count + cities.count - 1) && indexPath.row < (cars.count + animals.count + cities.count + sports.count) {
            cell.photo.image = UIImage(named: sports[indexPath.row - cars.count - animals.count - cities.count])
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.frame.width / 2) - 20
        
        return CGSize(width: itemWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
