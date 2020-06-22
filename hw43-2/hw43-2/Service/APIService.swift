//
//  APIService.swift
//  hw43-2
//
//  Created by Admin on 6/22/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class APIService {
    
    func fetchDrink(id: String, completion: @escaping (Drink) -> ()) {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in

            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let drinkResponse = try decoder.decode(DrinkResponse.self, from: data)
                completion(drinkResponse.drinks[0])
            } catch {print(error.localizedDescription)}

        }.resume()
    }
    
    func fetchCategory(category: String, completion: @escaping (Categories) -> ()) {
        let categoryURL = category.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(categoryURL)") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in

            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let categories = try decoder.decode(Categories.self, from: data)
                completion(categories)
            } catch {print(error.localizedDescription)}

        }.resume()
    }
    
    
}
