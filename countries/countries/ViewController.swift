//
//  ViewController.swift
//  countries
//
//  Created by Admin on 5/20/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countryTable: UITableView!
    
    var countries = [Country]()
    var filteredCountries = [Country]()
    
    let API = APIServices()
    
    var selectedCountry: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countryTable.delegate = self
        countryTable.dataSource = self
        
        searchBar.delegate = self
        
        API.fetchCountries { (countries) in
            for country in countries {
                self.countries.append(country)
            }
            

            self.filteredCountries = self.countries

            DispatchQueue.main.async {
                self.countryTable.reloadData()
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "country_info_segue" {
            if let infoVC = segue.destination as? InfoViewController {

                var currencyText: String?
                var bordersText: String?
                var languagesText: String?
                
                for (currencySymbol, currencyCode) in self.selectedCountry!.currencies! {
                    if let text = currencyText {
                        currencyText = text + ("\(currencySymbol) - \(currencyCode)\n")
                    } else {
                        currencyText = ("\(currencySymbol) - \(currencyCode)\n")
                    }
                }

                for border in self.selectedCountry!.borders! {
                    if let text = bordersText {
                        bordersText = text + ", \(border)"
                    } else {
                        bordersText = "Borders with: \(border)"
                    }
                }
                
                for language in self.selectedCountry!.languages! {
                    if let text = languagesText {
                        languagesText = text + ", \(language)"
                    } else {
                        languagesText = "Languages: \(language)"
                    }
                }
                
                infoVC.name = self.selectedCountry?.name
                infoVC.capital = self.selectedCountry?.capital
                infoVC.region = self.selectedCountry?.region
                infoVC.area = self.selectedCountry?.area?.string ?? "No Data"
                infoVC.population = self.selectedCountry?.population?.string
                infoVC.currencies = currencyText ?? "NO CURRENCY DATA"
                infoVC.borders = bordersText ?? "No borders"
                infoVC.languages = languagesText ?? "No language data"
            }
        }
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCountry = filteredCountries[indexPath.row]
        performSegue(withIdentifier: "country_info_segue", sender: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTable.dequeueReusableCell(withIdentifier: "country_cell", for: indexPath) as! CountryTableViewCell
        
        var currencyText: String?
        var bordersText: String?
        
        for (currencySymbol, currencyCode) in filteredCountries[indexPath.row].currencies! {
            if let text = currencyText {
                currencyText = text + ("\(currencySymbol) - \(currencyCode)\n")
            } else {
                currencyText = ("\(currencySymbol) - \(currencyCode)\n")
            }
        }
        
        for border in filteredCountries[indexPath.row].borders! {
            if let text = bordersText {
                bordersText = text + ", \(border)"
            } else {
                bordersText = "Borders with: \(border)"
            }
        }
        
        cell.countryLabel.text = filteredCountries[indexPath.row].name!
        cell.capitalLabel.text = filteredCountries[indexPath.row].capital!
        cell.currencyLabel.text = currencyText ?? "NO CURRENCY DATA"
        cell.bordersLabel.text = bordersText ?? "No borders"
        
        return cell
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.filteredCountries = self.countries
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.filteredCountries = self.countries.filter { (country) -> Bool in
                    country.name!.lowercased().contains(searchText.lowercased()) || country.capital!.lowercased().contains(searchText.lowercased())
                }
                self.countryTable.reloadData()
            }
        }
        
    }
}


extension LosslessStringConvertible {
    var string: String { .init(self) }
}
