//
//  HomeViewController.swift
//  TheCocktailDB
//
//  Created by Admin on 5/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    @IBOutlet weak var categoryLabel1: UILabel!
    @IBOutlet weak var categoryCollection1: UICollectionView!
    @IBOutlet weak var category2Label: UILabel!
    @IBOutlet weak var categoryCollection2: UICollectionView!
    
    @IBOutlet weak var randomDrinkImage: UIImageView!
    @IBOutlet weak var randomDrinkName: UILabel!
    @IBOutlet weak var randomDrinkCategory: UILabel!
    @IBOutlet weak var randomDrinkIngredients: UILabel!
    @IBOutlet weak var randomDrinkView: UIView!
    
    
    @IBOutlet weak var category1All: UILabel!
    @IBOutlet weak var category1Arrow: UIImageView!
    
    @IBOutlet weak var category2All: UILabel!
    @IBOutlet weak var category2Arrow: UIImageView!
    
    
    var randomDrink: Drink?
    
    
    var service = APIServices()
    var categoryList = [String]()
    var selectedCategories = Set<Int>()
    var category1Drinks = [Drink]()
    var category2Drinks = [Drink]()
    
    var selectedDrink: Drink?
    
    var selectedCategory: String?
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryCollection1.delegate = self
        categoryCollection1.dataSource = self
        categoryCollection2.delegate = self
        categoryCollection2.dataSource = self
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        service.fetchCategories() { (categories) in
            self.categoryList.append(contentsOf: categories)

            DispatchQueue.main.async {
                self.categoryCollection.reloadData()
            }

            while self.selectedCategories.count < 6 {
                self.selectedCategories.insert(Int.random(in: 0...(self.categoryList.count - 1)))
            }

            for (index, item) in self.selectedCategories.enumerated() {
                switch index {
                case 0:
                    self.service.fetchCategory(category: self.categoryList[item]) { (drinks) in
                        for id in drinks {
                            self.service.fetchDrink(id: id) { (drink) in
                                self.category1Drinks.append(drink)
                                DispatchQueue.main.async {
                                    self.categoryLabel1.text = self.categoryList[item]

                                    self.categoryCollection1.reloadData()
                                }
                            }
                        }
                    }
                case 1:
                    self.service.fetchCategory(category: self.categoryList[item]) { (drinks) in
                        for id in drinks {
                            self.service.fetchDrink(id: id) { (drink) in
                                self.category2Drinks.append(drink)
                                DispatchQueue.main.async {
                                    self.category2Label.text = self.categoryList[item]

                                    self.categoryCollection2.reloadData()
                                }
                            }
                        }
                    }
                default:
                    print("")
                }
            }
        }
        
        service.fetchRandom() { (drink) in
            
            var ingredientText = ""
            
            
            for (index, item) in drink.ingredients!.enumerated() {
                if index == 0 && item.0 != "" {
                    ingredientText = item.0
                } else if item.0 != ""  {
                    ingredientText = ingredientText + ", \(item.0)"
                }
            }
            self.randomDrink = drink
            DispatchQueue.main.async {
                let url = URL(string: drink.image!)
                self.randomDrinkImage.kf.setImage(with: url)
                self.randomDrinkImage.layer.masksToBounds = true
                self.randomDrinkImage.layer.cornerRadius = 10
                self.randomDrinkName.text = drink.name
                self.randomDrinkCategory.text = drink.category
                self.randomDrinkIngredients.text = ingredientText
            }
        }
        
        
        randomDrinkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(randomDrinkDetails)))
        
        
        category1All.isUserInteractionEnabled = true
        category1Arrow.isUserInteractionEnabled = true
        
        category2All.isUserInteractionEnabled = true
        category2Arrow.isUserInteractionEnabled = true
        
        category1All.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryOneDetails)))
        category1Arrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryOneDetails)))
        
        category2All.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryTwoDetails)))
        category2Arrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryTwoDetails)))
    }
        
    
    @objc func randomDrinkDetails() {
        self.selectedDrink = randomDrink
        self.performSegue(withIdentifier: "drink_details_segue", sender: nil)
    }
    
    @objc func categoryOneDetails() {
        self.selectedCategory = categoryList[0]
        self.performSegue(withIdentifier: "category_list_segue", sender: nil)
    }
    
    @objc func categoryTwoDetails() {
        self.selectedCategory = categoryList[1]
        self.performSegue(withIdentifier: "category_list_segue", sender: nil)
    }
    
    func addGradientToView(view: UIView) {
        //gradient layer
        let gradientLayer = CAGradientLayer()
        
        //define colors
        gradientLayer.colors = [UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0).cgColor, UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor, UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor]
        
        //define locations of colors as NSNumbers in range from 0.0 to 1.0
        //if locations not provided the colors will spread evenly
        gradientLayer.locations = [0.0, 0.7, 1]
        
        //define frame
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = 10
        gradientLayer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        //insert the gradient layer to the view layer
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "drink_details_segue" {
            if let detailsVC = segue.destination as? DrinkViewController {
                detailsVC.currentDrink = self.selectedDrink
            }
        }
        if let identifier = segue.identifier, identifier == "category_list_segue" {
            if let listVC = segue.destination as? CategoryViewController {
                listVC.currentCategory = self.selectedCategory
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            self.selectedDrink = category1Drinks[indexPath.row]
            performSegue(withIdentifier: "drink_details_segue", sender: nil)
        } else if collectionView.tag == 2 {
            self.selectedDrink = category2Drinks[indexPath.row]
            performSegue(withIdentifier: "drink_details_segue", sender: nil)
        } else if collectionView.tag == 3 {
            self.selectedCategory = categoryList[indexPath.row]
            self.performSegue(withIdentifier: "category_list_segue", sender: nil)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            if category1Drinks.count < 10 {
                return category1Drinks.count
            }
        } else if collectionView.tag == 2 {
            if category2Drinks.count < 10 {
                return category2Drinks.count
            }
        } else if collectionView.tag == 3 {
            return categoryList.count
        }
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category1_cell", for: indexPath) as! DrinkCollectionViewCell
            let url = URL(string: category1Drinks[indexPath.row].image!)
            cell.drinkPhoto.kf.setImage(with: url)
            cell.drinkPhoto.layer.masksToBounds = true
            cell.drinkPhoto.layer.cornerRadius = 10
            cell.labelBg.layer.cornerRadius = 10
            cell.labelBg.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.drinkName.text = category1Drinks[indexPath.row].name
            addGradientToView(view: cell.labelBg)
            return cell
        }
        
        if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category1_cell", for: indexPath) as! DrinkCollectionViewCell
            let url = URL(string: category2Drinks[indexPath.row].image!)
            cell.drinkPhoto.kf.setImage(with: url)
            cell.drinkPhoto.layer.masksToBounds = true
            cell.drinkPhoto.layer.cornerRadius = 10
            cell.labelBg.layer.cornerRadius = 10
            cell.labelBg.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.drinkName.text = category2Drinks[indexPath.row].name
            cell.labelBg.addGradientToView()
            return cell
        }
        
        if collectionView.tag == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories_cell", for: indexPath) as! CategoryCollectionViewCell
            
            cell.categoryName.text = categoryList[indexPath.row]
            cell.categoryName.textColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0)
            cell.layer.cornerRadius = 20
            cell.layer.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0).cgColor
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
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

extension UIView {
    func addGradientToView() {
        //gradient layer
        let gradientLayer = CAGradientLayer()
        
        //define colors
        gradientLayer.colors = [UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0).cgColor, UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor, UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor]
        
        //define locations of colors as NSNumbers in range from 0.0 to 1.0
        //if locations not provided the colors will spread evenly
        gradientLayer.locations = [0.0, 0.7, 1]
        
        //define frame
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 10
        gradientLayer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        //insert the gradient layer to the view layer
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
