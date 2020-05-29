//
//  IngredientDetailsViewController.swift
//  TheCocktailDB
//
//  Created by Admin on 5/26/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Kingfisher

class IngredientDetailsViewController: UIViewController {
    @IBOutlet weak var imageBg: UIView!
    @IBOutlet weak var ingredientImage: UIImageView!
    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var ingType: UILabel!
    @IBOutlet weak var ingAlc: UILabel!
    @IBOutlet weak var ingABV: UILabel!
    @IBOutlet weak var ingInfo: UILabel!
    
    @IBOutlet weak var drinksTableTitle: UILabel!
    @IBOutlet weak var drinksTable: UITableView!
    @IBOutlet weak var drinksTableHeight: NSLayoutConstraint!
    
    let bgColors = [
        UIColor.systemBlue.withAlphaComponent(0.05),
        UIColor.systemGray.withAlphaComponent(0.05),
        UIColor.systemGreen.withAlphaComponent(0.05),
        UIColor.systemRed.withAlphaComponent(0.05),
        UIColor.systemYellow.withAlphaComponent(0.05)
    ]
    
    var currentIngredient: Ingredient?
    
    var ingredientDrinks = [Drink]()
    
    let service = APIServices()
    
    var selectedDrink: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        imageBg.layer.cornerRadius = 200
        imageBg.backgroundColor = bgColors[Int.random(in: 0...(bgColors.count - 1))]
        
        ingredientName.text = currentIngredient!.name
        let url = URL(string: "https://www.thecocktaildb.com/images/ingredients/\(currentIngredient!.name!).png")
        ingredientImage.kf.setImage(with: url)
        
        ingType.text = "Type: \(currentIngredient!.type! == "" ? "No Data" : currentIngredient!.type!)"
        ingAlc.text = "Alcoholic: \(currentIngredient!.alcoholic! == "" ? "No" : currentIngredient!.alcoholic!)"
        ingABV.text = "ABV: \(currentIngredient!.alcVolume! == "" ? "No Data" : ("\(currentIngredient!.alcVolume! + "%")"))"
    
        ingInfo.text = currentIngredient!.description
        
        drinksTableTitle.text = "Drinks with \(currentIngredient!.name!)"
        
        drinksTable.delegate = self
        drinksTable.dataSource = self
        drinksTable.isScrollEnabled = false
        
        service.fetchByIngredient(ingredient: currentIngredient!.name!) { (drinks) in
            for id in drinks {
                self.service.fetchDrink(id: id) { (drink) in
                    self.ingredientDrinks.append(drink)
                    DispatchQueue.main.async {
                        self.drinksTable.reloadData()
                        self.updateViewConstraints()
                        self.drinksTable.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
    
    override func updateViewConstraints() {
        drinksTableHeight.constant = CGFloat(ingredientDrinks.count * 111)
        if ingredientDrinks.count == 0 {
            drinksTableTitle.text = ""
        } else {
            drinksTableTitle.text = "Drinks with \(currentIngredient!.name!)"
        }
        
        super.updateViewConstraints()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "from_ingredient_to_drink" {
            if let drinkVC = segue.destination as? DrinkViewController {
                drinkVC.currentDrink = selectedDrink
            }
        }
    }

}

extension IngredientDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDrink = ingredientDrinks[indexPath.row]
        performSegue(withIdentifier: "from_ingredient_to_drink", sender: nil)
    }
}

extension IngredientDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientDrinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = drinksTable.dequeueReusableCell(withIdentifier: "ingredient_drink_cell", for: indexPath) as! IngredientDrinkTableViewCell

        let url = URL(string: ingredientDrinks[indexPath.row].image!)
        cell.drinkImage.kf.setImage(with: url)
        cell.drinkImage.layer.masksToBounds = true
        cell.drinkImage.layer.cornerRadius = 10
        cell.drinkName.text = ingredientDrinks[indexPath.row].name
        cell.drinkCategory.text = ingredientDrinks[indexPath.row].category
        return cell
    }
    
    
}
