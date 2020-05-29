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
    
    @IBOutlet weak var recentTableHeight: NSLayoutConstraint!
    
    let cd = CDServices()
    let service = APIServices()
    
    var currentUser = User()
    
    var favorites = [Favorite]()
    
    var favoriteDrinks = [Drink]()
    
    var selectedDrink: Drink?
    
    var recents = [Drink]()
    
    @IBOutlet weak var seeAllFavoritesArrow: UIImageView!
    @IBOutlet weak var seeAllFavorites: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentUser = cd.fetchCurrentUser()
        signOutBtn.imageView?.image = signOutBtn.imageView?.image?.withRenderingMode(.alwaysTemplate)
        signOutBtn.imageView?.tintColor = UIColor.systemPink
        userFullName.text = "\(currentUser.firstname!.capitalized) \(currentUser.lastname!.capitalized)"
        userEmail.text = currentUser.email
        
        favoritesCollection.delegate = self
        favoritesCollection.dataSource = self
        recentTable.delegate = self
        recentTable.dataSource = self
        
        var idList = [String]()
        for item in cd.getFavorites() {
            idList.append(item.id!)
        }
        addDrinkToFavorites(ids: idList, index: 0)
        
        
        var idList1 = [String]()
        for item in cd.getRecents() {
            idList1.append(item.id!)
        }
        addDrinkToRecents(ids: idList1, index: 0)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didRecieveFavorite(with:)),
            name: NSNotification.Name("update_favorite"),
            object: nil)
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didRecieveRecent(with:)),
            name: NSNotification.Name("update_recent"),
            object: nil)
        
        seeAllFavorites.isUserInteractionEnabled = true
        seeAllFavoritesArrow.isUserInteractionEnabled = true
        seeAllFavorites.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteDrinksSegue)))
        seeAllFavoritesArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteDrinksSegue)))
    }
    
    @objc func favoriteDrinksSegue() {
        performSegue(withIdentifier: "favorite_list_segue", sender: nil)
    }
    
    @objc func didRecieveFavorite(with notification: Notification) {
        favoriteDrinks.removeAll()
        var idList = [String]()
        for item in cd.getFavorites() {
            idList.append(item.id!)
        }
        addDrinkToFavorites(ids: idList, index: 0)
    }
    
    
    @objc func didRecieveRecent(with notification: Notification) {
        recents.removeAll()
        var idList = [String]()
        for item in cd.getRecents() {
            idList.append(item.id!)
        }
        addDrinkToRecents(ids: idList, index: 0)
    }
    
    func addDrinkToFavorites(ids: [String], index: Int) {
        let idList = ids
        if index < idList.count {
            service.fetchDrink(id: idList[index]) { (drink) in
                self.favoriteDrinks.append(drink)
                DispatchQueue.main.async {
                    self.addDrinkToFavorites(ids: idList, index: index + 1)
                    self.favoritesCollection.reloadData()
                }

            }
        }
    }
    
    func addDrinkToRecents(ids: [String], index: Int) {
        let idList = ids
        if index < idList.count {
            service.fetchDrink(id: idList[index]) { (drink) in
                self.recents.append(drink)
                DispatchQueue.main.async {
                    self.addDrinkToRecents(ids: idList, index: index + 1)
                    self.recentTable.reloadData()
                    self.updateViewConstraints()
                    self.recentTable.layoutIfNeeded()
                }

            }
        }
    }
    
    override func updateViewConstraints() {
        recentTableHeight.constant = CGFloat(recentTable.numberOfRows(inSection: 0) * 111)
        
        super.updateViewConstraints()
    }
    
    @IBAction func onSignOut(_ sender: UIButton) {
        sender.imageView?.tintColor = UIColor.systemPink.withAlphaComponent(0.7)
        UDManager.setSigned(value: false)
        UDManager.setUser(value: "")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "favorite_details_segue" {
            if let detailsVC = segue.destination as? DrinkViewController {
                detailsVC.currentDrink = self.selectedDrink
            }
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDrink = favoriteDrinks[indexPath.row]
        performSegue(withIdentifier: "favorite_details_segue", sender: nil)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if favoriteDrinks.count < 10 {
            return favoriteDrinks.count
        }
        
        return 10
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
        return cell
    }
    
    
}


extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDrink = recents[indexPath.row]
        performSegue(withIdentifier: "favorite_details_segue", sender: nil)
    }
    
}
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recents.count < 5 {
            return recents.count
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentTable.dequeueReusableCell(withIdentifier: "recent_drink_cell", for: indexPath) as! RecentTableViewCell
        
        let url = URL(string: recents[indexPath.row].image ?? "")
        cell.drinkImage.kf.setImage(with: url)
        cell.drinkImage.layer.masksToBounds = true
        cell.drinkImage.layer.cornerRadius = 10
        cell.drinkName.text = recents[indexPath.row].name
        cell.drinkCategory.text = recents[indexPath.row].category
        
        return cell
    }
    
    
}
