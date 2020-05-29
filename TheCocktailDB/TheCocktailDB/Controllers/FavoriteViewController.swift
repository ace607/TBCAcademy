//
//  FavoriteViewController.swift
//  TheCocktailDB
//
//  Created by Admin on 5/28/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var drinkCount: UILabel!
    @IBOutlet weak var favoriteListCollection: UICollectionView!
    
    let cd = CDServices()
    let service = APIServices()
    
    var favoriteDrinks = [Drink]()
    
    var selectedDrink: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        favoriteListCollection.delegate = self
        favoriteListCollection.dataSource = self
        
        for item in cd.getFavorites() {
            service.fetchDrink(id: item.id!) { (drink) in
                self.favoriteDrinks.append(drink)
                DispatchQueue.main.async {
                    self.drinkCount.text = "\(self.favoriteDrinks.count) Items"
                    self.favoriteListCollection.reloadData()
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
                  DispatchQueue.main.async {
                      self.favoriteListCollection.reloadData()
                  }

              }
          }
      }
      
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "favorite_drink_list_details_segue" {
            if let detailsVC = segue.destination as? DrinkViewController {
                detailsVC.currentDrink = selectedDrink
            }
        }
    }

}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDrink = favoriteDrinks[indexPath.row]
        performSegue(withIdentifier: "favorite_drink_list_details_segue", sender: nil)
    }
}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteDrinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteListCollection.dequeueReusableCell(withReuseIdentifier: "favorite_list_cell", for: indexPath) as! FavoriteListCollectionViewCell
        
        
        let url = URL(string: favoriteDrinks[indexPath.row].image!)
        cell.drinkImage.kf.setImage(with: url)
        cell.drinkName.text = favoriteDrinks[indexPath.row].name
        cell.drinkImage.layer.masksToBounds = true
        cell.drinkImage.layer.cornerRadius = 10
        cell.labelBg.layer.cornerRadius = 10
        cell.labelBg.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        return cell
    }
    
    
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.safeAreaLayoutGuide.layoutFrame.width / 2) - (45/2)
        let height = width
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
