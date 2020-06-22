//
//  MainViewController.swift
//  hw43-2
//
//  Created by Admin on 6/22/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var catOne: UILabel!
    @IBOutlet weak var catTwo: UILabel!
    @IBOutlet weak var catThree: UILabel!
    @IBOutlet weak var catFour: UILabel!
    
    
    @IBOutlet weak var collZero: UICollectionView!
    @IBOutlet weak var collOne: UICollectionView!
    @IBOutlet weak var collTwo: UICollectionView!
    @IBOutlet weak var collThree: UICollectionView!
    
    let drinkViewModel = DrinkViewModel()
    
    var cat1Drinks = [(Drink, UIImage)]()
    var cat2Drinks = [(Drink, UIImage)]()
    var cat3Drinks = [(Drink, UIImage)]()
    var cat4Drinks = [(Drink, UIImage)]()
    
    var selectedDrink: (Drink, UIImage)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collZero.delegate = self
        collZero.dataSource = self
        collOne.delegate = self
        collOne.dataSource = self
        collTwo.delegate = self
        collTwo.dataSource = self
        collThree.delegate = self
        collThree.dataSource = self
        
        let categories = ["Shot", "Homemade Liqueur", "Punch / Party Drink", "Cocktail"]
        
        catOne.text = categories[0]
        catTwo.text = categories[1]
        catThree.text = categories[2]
        catFour.text = categories[3]
        
        drinkViewModel.getDrinksForCategories(categories[0]) { (drinks) in
            self.cat1Drinks.removeAll()
            self.cat1Drinks.append(contentsOf: drinks)
            DispatchQueue.main.async {
                self.collZero.reloadData()
            }
        }
        
        
        drinkViewModel.getDrinksForCategories(categories[1]) { (drinks) in
            self.cat2Drinks.removeAll()
            self.cat2Drinks.append(contentsOf: drinks)
            DispatchQueue.main.async {
                self.collOne.reloadData()
            }
        }
        
        drinkViewModel.getDrinksForCategories(categories[2]) { (drinks) in
        self.cat3Drinks.removeAll()
            self.cat3Drinks.append(contentsOf: drinks)
            DispatchQueue.main.async {
                self.collTwo.reloadData()
            }
        }
        
        drinkViewModel.getDrinksForCategories(categories[3]) { (drinks) in
        self.cat4Drinks.removeAll()
            self.cat4Drinks.append(contentsOf: drinks)
            DispatchQueue.main.async {
                self.collThree.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_details" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.selectedDrink = self.selectedDrink
            }
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
        case 0:
            self.selectedDrink = cat1Drinks[indexPath.row]
        case 1:
            self.selectedDrink = cat2Drinks[indexPath.row]
        case 2:
            self.selectedDrink = cat3Drinks[indexPath.row]
        case 3:
            self.selectedDrink = cat4Drinks[indexPath.row]
        default:
            print("")
        }
        
        performSegue(withIdentifier: "show_details", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return cat1Drinks.count
        case 1:
            return cat2Drinks.count
        case 2:
            return cat3Drinks.count
        case 3:
            return cat4Drinks.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drink_cell", for: indexPath) as! DrinkCollectionViewCell
        
        switch collectionView.tag {
        case 0:
            cell.drink = cat1Drinks[indexPath.row]
        case 1:
            cell.drink = cat2Drinks[indexPath.row]
        case 2:
            cell.drink = cat3Drinks[indexPath.row]
        case 3:
            cell.drink = cat4Drinks[indexPath.row]
        default:
            print("")
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
}
