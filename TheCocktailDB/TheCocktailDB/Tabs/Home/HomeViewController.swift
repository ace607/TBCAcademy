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
    @IBOutlet weak var category3Label: UILabel!
    @IBOutlet weak var categoryCollection3: UICollectionView!
    @IBOutlet weak var category4Label: UILabel!
    @IBOutlet weak var categoryCollection4: UICollectionView!
    
    @IBOutlet weak var randomDrinkImage: UIImageView!
    @IBOutlet weak var randomDrinkName: UILabel!
    @IBOutlet weak var randomDrinkCategory: UILabel!
    @IBOutlet weak var randomDrinkIngredients: UILabel!
    @IBOutlet weak var randomDrinkView: UIView!
    @IBOutlet weak var randomImageHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var randomFavBtn: UIButton!
    @IBOutlet weak var randomViewBtn: UIButton!
    @IBOutlet weak var randomReloadBtn: UIButton!
    
    
    
    
    @IBOutlet weak var category1All: UILabel!
    @IBOutlet weak var category1Arrow: UIImageView!
    
    @IBOutlet weak var category2All: UILabel!
    @IBOutlet weak var category2Arrow: UIImageView!
    
    @IBOutlet weak var category3All: UILabel!
    @IBOutlet weak var category3Arrow: UIImageView!
    
    @IBOutlet weak var category4All: UILabel!
    @IBOutlet weak var category4Arrow: UIImageView!
    
    
    
    var randomDrink: Drink?
    var isRandomFavorite = false
    
    
    let service = APIServices()
    var categoryList = [String]()
    var selectedCategories = Set<Int>()
    var category1Drinks = [Drink]()
    var category2Drinks = [Drink]()
    var category3Drinks = [Drink]()
    var category4Drinks = [Drink]()
    
    var selectedDrink: Drink?
    
    var selectedCategory: String?
    
    
    
    @IBOutlet weak var ingredientCollection: UICollectionView!
    
    @IBOutlet weak var ingredientsAll: UILabel!
    @IBOutlet weak var ingredientsArrow: UIImageView!
    
    var ingredientList = [String]()
    var ingredients = [Ingredient]()
    var selectedIngredient: Ingredient?
    
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryCollection1.delegate = self
        categoryCollection1.dataSource = self
        categoryCollection2.delegate = self
        categoryCollection2.dataSource = self
        categoryCollection3.delegate = self
        categoryCollection3.dataSource = self
        categoryCollection4.delegate = self
        categoryCollection4.dataSource = self
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        
        ingredientCollection.delegate = self
        ingredientCollection.dataSource = self
        
        service.fetchCategories() { (categories) in
            self.categoryList.append(contentsOf: categories)

            DispatchQueue.main.async {
                self.categoryCollection.reloadData()
            }

            while self.selectedCategories.count < 4 {
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
                                   
                                    if self.category1Drinks.count > 1 {
                                        self.category1Drinks.shuffle()
                                    }

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
                                    
                                    if self.category2Drinks.count > 1 {
                                        self.category2Drinks.shuffle()
                                    }

                                    self.categoryCollection2.reloadData()
                                }
                            }
                        }
                    }
                case 2:
                    self.service.fetchCategory(category: self.categoryList[item]) { (drinks) in
                        for id in drinks {
                            self.service.fetchDrink(id: id) { (drink) in
                                self.category3Drinks.append(drink)
                                DispatchQueue.main.async {
                                    self.category3Label.text = self.categoryList[item]
                                    
                                    if self.category3Drinks.count > 1 {
                                        self.category3Drinks.shuffle()
                                    }
                                    
                                    self.categoryCollection3.reloadData()
                                }
                            }
                        }
                    }
                case 3:
                    self.service.fetchCategory(category: self.categoryList[item]) { (drinks) in
                        for id in drinks {
                            self.service.fetchDrink(id: id) { (drink) in
                                self.category4Drinks.append(drink)
                                DispatchQueue.main.async {
                                    self.category4Label.text = self.categoryList[item]
                                    
                                    if self.category4Drinks.count > 1 {
                                        self.category4Drinks.shuffle()
                                    }
                                    
                                    self.categoryCollection4.reloadData()
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
                self.randomDrinkName.text = drink.name
                self.randomDrinkCategory.text = drink.category
                self.randomDrinkIngredients.text = ingredientText
            }
        }
        
        service.fetchIngredients() { (ingredients) in
            self.ingredientList.append(contentsOf: ingredients)
            for ingredient in ingredients {
                self.service.fetchIngredient(name: ingredient) { (ingredient) in
                    self.ingredients.append(ingredient)
                    DispatchQueue.main.async {
                        if ingredients.count > 1 {
                            self.ingredients.shuffle()
                        }
                        
                        self.ingredientCollection.reloadData()
                    }
                }

            }
        }

        randomDrinkImage.layer.masksToBounds = true
        randomDrinkImage.layer.cornerRadius = 10
        randomFavBtn.layer.cornerRadius = 30
        randomViewBtn.layer.cornerRadius = 30
        randomReloadBtn.layer.cornerRadius = 30
        
        randomDrinkView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:0.6)
        
        
        category1All.isUserInteractionEnabled = true
        category1Arrow.isUserInteractionEnabled = true
        
        category2All.isUserInteractionEnabled = true
        category2Arrow.isUserInteractionEnabled = true
        
        category3All.isUserInteractionEnabled = true
        category3Arrow.isUserInteractionEnabled = true
        
        category4All.isUserInteractionEnabled = true
        category4Arrow.isUserInteractionEnabled = true
        
        
        ingredientsAll.isUserInteractionEnabled = true
        ingredientsArrow.isUserInteractionEnabled = true
        
        category1All.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryOneDetails)))
        category1Arrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryOneDetails)))
        
        category2All.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryTwoDetails)))
        category2Arrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryTwoDetails)))
        
        category3All.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryThreeDetails)))
        category3Arrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryThreeDetails)))
        
        category4All.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryFourDetails)))
        category4Arrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryFourDetails)))
        
        
        ingredientsAll.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allIngredients)))
        ingredientsArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allIngredients)))
    }

    override func updateViewConstraints() {
        randomImageHeight.constant = randomDrinkImage.frame.width
        super.updateViewConstraints()
    }
    
    @objc func categoryOneDetails() {
        self.selectedCategory = categoryLabel1.text
        self.performSegue(withIdentifier: "category_list_segue", sender: nil)
    }
    
    @objc func categoryTwoDetails() {
        self.selectedCategory = category2Label.text
        self.performSegue(withIdentifier: "category_list_segue", sender: nil)
    }
    
    @objc func categoryThreeDetails() {
        self.selectedCategory = category3Label.text
        self.performSegue(withIdentifier: "category_list_segue", sender: nil)
    }
    
    @objc func categoryFourDetails() {
        self.selectedCategory = category4Label.text
        self.performSegue(withIdentifier: "category_list_segue", sender: nil)
    }
    
    @objc func allIngredients() {
        self.performSegue(withIdentifier: "ingredient_list_segue", sender: nil)
    }

    
    @IBAction func onRandomFav(_ sender: UIButton) {
        if isRandomFavorite {
            randomFavBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            isRandomFavorite = false
        } else {
            randomFavBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isRandomFavorite = true
        }
    }
    
    @IBAction func onRandomView(_ sender: UIButton) {
        self.selectedDrink = randomDrink
        self.performSegue(withIdentifier: "drink_details_segue", sender: nil)
    }
    
    @IBAction func onRandomReload(_ sender: UIButton) {

        UIView.transition(with: randomDrinkView, duration: 0.7, options: .transitionFlipFromLeft,
        animations: {
        }, completion: nil)

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
                self.randomDrinkName.text = drink.name
                self.randomDrinkCategory.text = drink.category
                self.randomDrinkIngredients.text = ingredientText
            }
        }
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
        if let identifier = segue.identifier, identifier == "ingredient_detail_segue" {
            if let detailsVC = segue.destination as? IngredientDetailsViewController {
                detailsVC.currentIngredient = self.selectedIngredient
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
        } else if collectionView.tag == 4 {
            self.selectedDrink = category3Drinks[indexPath.row]
            performSegue(withIdentifier: "drink_details_segue", sender: nil)
        } else if collectionView.tag == 5 {
            self.selectedDrink = category4Drinks[indexPath.row]
            performSegue(withIdentifier: "drink_details_segue", sender: nil)
        } else if collectionView.tag == 6 {
            self.selectedIngredient = ingredients[indexPath.row]
            performSegue(withIdentifier: "ingredient_detail_segue", sender: nil)
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
        } else if collectionView.tag == 4 {
            if category3Drinks.count < 10 {
                return category3Drinks.count
            }
        } else if collectionView.tag == 5 {
            if category4Drinks.count < 10 {
                return category4Drinks.count
            }
        } else if collectionView.tag == 6 {
            if ingredients.count < 10 {
                return ingredients.count
            }
        }
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category1_cell", for: indexPath) as! DrinkCollectionViewCell
            let url = URL(string: category1Drinks[indexPath.row].image ?? "")
            cell.drinkPhoto.kf.setImage(with: url)
            cell.drinkPhoto.layer.masksToBounds = true
            cell.drinkPhoto.layer.cornerRadius = 10
            cell.labelBg.layer.cornerRadius = 10
            cell.labelBg.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.drinkName.text = category1Drinks[indexPath.row].name
            cell.labelBg.addGradientToView()
            return cell
        }
        
        if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category1_cell", for: indexPath) as! DrinkCollectionViewCell
            let url = URL(string: category2Drinks[indexPath.row].image ?? "")
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
        
        if collectionView.tag == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category1_cell", for: indexPath) as! DrinkCollectionViewCell
            let url = URL(string: category3Drinks[indexPath.row].image ?? "")
            cell.drinkPhoto.kf.setImage(with: url)
            cell.drinkPhoto.layer.masksToBounds = true
            cell.drinkPhoto.layer.cornerRadius = 10
            cell.labelBg.layer.cornerRadius = 10
            cell.labelBg.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.drinkName.text = category3Drinks[indexPath.row].name
            cell.labelBg.addGradientToView()
            return cell
        }
        
        if collectionView.tag == 5 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category1_cell", for: indexPath) as! DrinkCollectionViewCell
            let url = URL(string: category4Drinks[indexPath.row].image ?? "")
            cell.drinkPhoto.kf.setImage(with: url)
            cell.drinkPhoto.layer.masksToBounds = true
            cell.drinkPhoto.layer.cornerRadius = 10
            cell.labelBg.layer.cornerRadius = 10
            cell.labelBg.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.drinkName.text = category4Drinks[indexPath.row].name
            cell.labelBg.addGradientToView()
            return cell
        }
        
        if collectionView.tag == 6 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredient_collection_cell", for: indexPath) as! IngredientCollectionViewCell
            
            let url = URL(string: "https://www.thecocktaildb.com/images/ingredients/\(ingredients[indexPath.row].name ?? "").png")
            cell.ingredientImage.kf.setImage(with: url)
            cell.ingredientName.text = ingredients[indexPath.row].name
            
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
