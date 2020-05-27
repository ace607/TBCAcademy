//
//  IngredientListViewController.swift
//  TheCocktailDB
//
//  Created by Admin on 5/26/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class IngredientListViewController: UIViewController {
    @IBOutlet weak var itemCount: UILabel!
    
    @IBOutlet weak var ingredientsCollection: UICollectionView!
    
    var service = APIServices()
    
    var ingredients = [Ingredient]()
    
    var selectedIngredient: Ingredient?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ingredientsCollection.delegate = self
        ingredientsCollection.dataSource = self
        
        service.fetchIngredients() { (ingredients) in
            for item in ingredients {
                self.service.fetchIngredient(name: item) { (ingredient) in
                    self.ingredients.append(ingredient)
                    DispatchQueue.main.async {
                        self.ingredientsCollection.reloadData()
                    }
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "ingredient_list_detail_segue" {
            if let detailsVC = segue.destination as? IngredientDetailsViewController {
                detailsVC.currentIngredient = selectedIngredient
            }
        }
    }

}

extension IngredientListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIngredient = ingredients[indexPath.row]
        performSegue(withIdentifier: "ingredient_list_detail_segue", sender: nil)
    }
}

extension IngredientListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ingredientsCollection.dequeueReusableCell(withReuseIdentifier: "ingredient_list_cell", for: indexPath) as! IngredientListCollectionViewCell

        let url = URL(string: "https://www.thecocktaildb.com/images/ingredients/\(ingredients[indexPath.row].name!).png")
        cell.ingredientImage.kf.setImage(with: url)
        cell.ingredientName.text = ingredients[indexPath.row].name
        
        return cell
    }
    
    
}

extension IngredientListViewController: UICollectionViewDelegateFlowLayout {
    
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
