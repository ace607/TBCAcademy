//
//  DrinkViewController.swift
//  TheCocktailDB
//
//  Created by Admin on 5/25/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Kingfisher

class DrinkViewController: UIViewController {
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkCategory: UILabel!
    @IBOutlet weak var isCreative: UILabel!
    @IBOutlet weak var creativeImage: UIImageView!
    @IBOutlet weak var drinkGlass: UILabel!
    @IBOutlet weak var glassImage: UIImageView!
    @IBOutlet weak var isAlcoholic: UILabel!
    @IBOutlet weak var alcImage: UIImageView!
    
    
    @IBOutlet weak var ingredientsTable: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var instructionText: UILabel!
    
    @IBOutlet weak var tagCollection: UICollectionView!
    @IBOutlet weak var tagCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var currentDrink: Drink?
    
    var ingredientCount = 0
    
    var isFavorite = false
    
    var service = APIServices()
    
    var ingredients = [Ingredient]()
    
    var selectedIngredient: Ingredient?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for item in currentDrink!.ingredients! {
            if item.0 != "" {
                ingredientCount += 1
            } else {
                break
            }
        }

        let url = URL(string: (currentDrink?.image)!)
        drinkImage.kf.setImage(with: url)
        
        ingredientsTable.delegate = self
        ingredientsTable.dataSource = self
        ingredientsTable.isScrollEnabled = false
        
        tagCollection.dataSource = self
        
        drinkName.text = currentDrink?.name
        drinkCategory.text = currentDrink?.category
        instructionText.text = currentDrink?.instructions
        
        if currentDrink?.creative == "Yes" {
            creativeImage.tintColor = UIColor.systemYellow
            creativeImage.image = UIImage(systemName: "star.fill")
            isCreative.text = "Creative"
        } else {
            creativeImage.tintColor = UIColor.black
            creativeImage.image = UIImage(systemName: "star")
            isCreative.text = "Ordinary"
        }
        drinkGlass.text = currentDrink?.glass
        
        
        isAlcoholic.text = currentDrink?.alcoholic
        
        if currentDrink?.alcoholic == "" {
            isAlcoholic.text = "Non Alcoholic"
        }
        
        favoriteBtn.layer.cornerRadius = 30
        
        for item in currentDrink!.ingredients! {
            self.service.fetchIngredient(name: item.0) { (ingredient) in
                self.ingredients.append(ingredient)
            }
        }

    }
    
    override func updateViewConstraints() {
        tableHeight.constant = ingredientsTable.contentSize.height
        if currentDrink?.tags.count == 0 {
            tagCollectionHeight.constant = 0
        }
        super.updateViewConstraints()
    }

    @IBAction func addToFavorites(_ sender: UIButton) {
        if isFavorite {
            favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            isFavorite = false
        } else {
            favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isFavorite = true
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
        if let identifier = segue.identifier, identifier == "from_drink_to_ingredient" {
            if let ingredientVC = segue.destination as? IngredientDetailsViewController {
                ingredientVC.currentIngredient = selectedIngredient
                selectedIngredient = nil
            }
        }
    }

}

extension DrinkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for ingredient in ingredients {
            if ingredient.name == currentDrink?.ingredients![indexPath.row].0 {
                selectedIngredient = ingredient
            }
        }

        if let _ = selectedIngredient {
            performSegue(withIdentifier: "from_drink_to_ingredient", sender: nil)
        }
    }
}

extension DrinkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientsTable.dequeueReusableCell(withIdentifier: "ingredient_cell", for: indexPath) as! IngredientTableViewCell
        
        cell.ingredientName.text = currentDrink?.ingredients![indexPath.row].0
        cell.ingredientMeasure.text = currentDrink?.ingredients![indexPath.row].1
        
        return cell
    }
    
    
}

extension DrinkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDrink!.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCollection.dequeueReusableCell(withReuseIdentifier: "tag_cell", for: indexPath) as! TagCollectionViewCell
        
        cell.tagName.text = currentDrink!.tags[indexPath.row]
        cell.tagName.textColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0)
        cell.layer.cornerRadius = 20
        cell.layer.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0).cgColor

        
        return cell
    }
    
    
}
