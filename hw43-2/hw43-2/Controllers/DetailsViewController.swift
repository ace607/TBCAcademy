//
//  DetailsViewController.swift
//  hw43-2
//
//  Created by Admin on 6/22/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var drinkImg: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var ingTable: UITableView!
    
    var selectedDrink: (Drink, UIImage)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingTable.delegate = self
        ingTable.dataSource = self
        
        self.title = selectedDrink?.0.name
        self.drinkName.text = selectedDrink?.0.name
        self.drinkImg.image = selectedDrink?.1
        
        
    }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDrink!.0.ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingTable.dequeueReusableCell(withIdentifier: "ing_cell", for: indexPath) as! IngredientTableViewCell
        
        cell.ingName.text = selectedDrink?.0.ingredientList[indexPath.row]
        
        return cell
    }
    
    
}
