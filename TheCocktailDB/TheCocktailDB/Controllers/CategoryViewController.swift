//
//  CategoryViewController.swift
//  TheCocktailDB
//
//  Created by Admin on 5/25/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var categoryListCollection: UICollectionView!
    
    var currentCategory: String?
    var items = [Drink]()
    
    let service = APIServices()
    
    var selectedDrink: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.itemCountLabel.text = "0 Items"
        service.fetchCategory(category: self.currentCategory!) { (ids) in
            for id in ids {
                self.service.fetchDrink(id: id) { (drink) in
                    self.items.append(drink)

                    DispatchQueue.main.async {
                        self.categoryListCollection.reloadData()
                        self.itemCountLabel.text = "\(self.items.count) items"
                    }
                }
            }
        }
        categoryListCollection.delegate = self
        categoryListCollection.dataSource = self
        categoryName.text = currentCategory
        
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "list_drink_segue" {
            if let detailsVC = segue.destination as? DrinkViewController {
                detailsVC.currentDrink = self.selectedDrink
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

}

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedDrink = items[indexPath.row]
        performSegue(withIdentifier: "list_drink_segue", sender: nil)
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryListCollection.dequeueReusableCell(withReuseIdentifier: "category_list_cell", for: indexPath) as! CategoryListCollectionViewCell
        
        let url = URL(string: items[indexPath.row].image!)
        cell.itemImage.kf.setImage(with: url)
        cell.itemName.text = items[indexPath.row].name
        cell.itemImage.layer.masksToBounds = true
        cell.itemImage.layer.cornerRadius = 10
        cell.labelView.layer.cornerRadius = 10
        cell.labelView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        return cell
    }
    
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
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
