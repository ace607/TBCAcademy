//
//  InfoViewController.swift
//  countries
//
//  Created by Admin on 5/21/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var countryRegion: UILabel!
    @IBOutlet weak var countryArea: UILabel!
    @IBOutlet weak var countryPopulation: UILabel!
    @IBOutlet weak var countryCurrency: UILabel!
    @IBOutlet weak var countryBorders: UILabel!
    @IBOutlet weak var countryLanguages: UILabel!
    
    var name: String?
    var capital: String?
    var region: String?
    var area: String?
    var population: String?
    var currencies: String?
    var borders: String?
    var languages: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        countryName.text = name
        countryCapital.text = "Capital: \(capital!)"
        countryRegion.text = "Region: \(region!)"
        countryArea.text = "Area: \(area!)"
        countryPopulation.text = "Population: \(population!)"
        countryCurrency.text = "Currencies: \(currencies!)"
        countryBorders.text = borders
        countryLanguages.text = languages
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
