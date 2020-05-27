//
//  SearchViewController.swift
//  TheCocktailDB
//
//  Created by Admin on 5/26/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTable: UITableView!
    
    var resultDrinks = [Drink]()
    
    let service = APIServices()
    
    var selectedDrink: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchTable.delegate = self
        searchTable.dataSource = self
        
        searchBar.delegate = self
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
        if let identifier = segue.identifier, identifier == "search_detail_segue" {
            if let detailsVC = segue.destination as? DrinkViewController {
                detailsVC.currentDrink = self.selectedDrink
            }
        }
    }

}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDrink = resultDrinks[indexPath.row]
        performSegue(withIdentifier: "search_detail_segue", sender: nil)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultDrinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTable.dequeueReusableCell(withIdentifier: "search_cell", for: indexPath) as! SearchTableViewCell

        let url = URL(string: resultDrinks[indexPath.row].image!)
        cell.itemImage.kf.setImage(with: url)
        cell.itemImage.layer.masksToBounds = true
        cell.itemImage.layer.cornerRadius = 10
        cell.itemName.text = resultDrinks[indexPath.row].name
        cell.itemCategory.text = resultDrinks[indexPath.row].category
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.resultDrinks.removeAll()
        if searchText == "" {
            self.searchTable.reloadData()
        } else {
            self.service.fetchSearch(text: searchText) { (drinks) in
                self.resultDrinks.append(contentsOf: drinks)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.searchTable.reloadData()
                }
            }
        }
    }
}
