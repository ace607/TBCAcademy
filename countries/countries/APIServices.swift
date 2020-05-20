//
//  APIServices.swift
//  countries
//
//  Created by Admin on 5/20/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class APIServices {
    
    typealias completion = ([Country]) -> ()
    
    func fetchCountries(completion: @escaping ([Country]) -> ()) {
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                var countries = [Country]()
                if let object = json as? [Dictionary<String, AnyObject>] {
                    for item in object {
                        var borders = [String]()
                        var languages = [String]()
                        var currencies = [(String, String)]()
                        for border in item["borders"] as! Array<String> {
                            borders.append(border)
                        }
                        if let languageList = item["languages"] as? [Dictionary<String, String>] {
                            for languageItem in languageList {
                                    languages.append(languageItem["name"]!)
                            }
                        }
                        
                        if let currencyList = item["currencies"] as? [Dictionary<String, String>] {
                            for currency in currencyList {
                                    currencies.append((currency["symbol"]!, currency["code"]!))
                            }
                        }

                        countries.append(Country(name: item["name"] as? String, capital: item["capital"] as? String, currencies: currencies, borders: borders, flag: item["flag"] as? String, languages: languages, region: item["region"] as? String, population: item["population"] as? Int, area: item["area"] as? Double))
                        

                    }
                }
                completion(countries)
            } catch {print(error.localizedDescription)}
            
        }.resume()
    }
}
