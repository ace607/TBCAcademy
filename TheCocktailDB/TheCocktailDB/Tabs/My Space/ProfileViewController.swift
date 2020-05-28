//
//  ProfileViewController.swift
//  TheCocktailDB
//
//  Created by Admin on 5/27/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userFullName: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var signOutBtn: UIButton!
    
    @IBOutlet weak var favoritesCollection: UICollectionView!
    
    @IBOutlet weak var recentTable: UITableView!
    
    let cd = CDServices()
    let service = APIServices()
    
    var currentUser = User()
    
    var favorites = [Favorite]()
    
    var favoriteDrinks = [Drink]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentUser = cd.fetchCurrentUser()
        signOutBtn.imageView?.image = signOutBtn.imageView?.image?.withRenderingMode(.alwaysTemplate)
        signOutBtn.imageView?.tintColor = UIColor.systemPink
        userFullName.text = "\(currentUser.firstname!.capitalized) \(currentUser.lastname!.capitalized)"
        userEmail.text = currentUser.email
        
        favoritesCollection.delegate = self
        favoritesCollection.dataSource = self
        
        for item in cd.getFavorites() {
            service.fetchDrink(id: item.id!) { (drink) in
                self.favoriteDrinks.append(drink)
                DispatchQueue.main.async {
                    self.favoritesCollection.reloadData()
                }

            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didRecieveFavorite(with:)),
            name: NSNotification.Name("update_favorite"),
            object: nil)
    }
    
    
    @objc func didRecieveFavorite(with notification: Notification) {
        favoriteDrinks.removeAll()
        for item in cd.getFavorites() {
            service.fetchDrink(id: item.id!) { (drink) in
                self.favoriteDrinks.append(drink)
                print(drink.id)
                DispatchQueue.main.async {
                    self.favoritesCollection.reloadData()
                }

            }
            print(item.id!)
        }
    }

    @IBAction func onSignOut(_ sender: UIButton) {
        sender.imageView?.tintColor = UIColor.systemPink.withAlphaComponent(0.7)
        UDManager.setSigned(value: false)
        UDManager.setUser(value: "")
        self.navigationController?.popViewController(animated: true)
    }

}

extension ProfileViewController: UICollectionViewDelegate {
    
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteDrinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoritesCollection.dequeueReusableCell(withReuseIdentifier: "favorite_cell", for: indexPath) as! FavoriteCollectionViewCell

        let url = URL(string: favoriteDrinks[indexPath.row].image ?? "")
        cell.drinkImage.kf.setImage(with: url)
        cell.drinkImage.layer.masksToBounds = true
        cell.drinkImage.layer.cornerRadius = 10
        cell.labelBg.layer.cornerRadius = 10
        cell.labelBg.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        cell.drinkName.text = favoriteDrinks[indexPath.row].name
        cell.labelBg.addGradientToView()
        return cell
    }
    
    
}
