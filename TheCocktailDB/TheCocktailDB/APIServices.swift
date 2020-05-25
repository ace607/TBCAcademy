//
//  APIServices.swift
//  TheCocktailDB
//
//  Created by Admin on 5/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class APIServices {
    
    typealias retudnDrinks = ([Drink]) -> ()
    typealias returnDrink = (Drink) -> ()
    
    func fetchCategories(completion: @escaping ([String]) -> ()){
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                var categories = [String]()
                if let object = json as? Dictionary<String, AnyObject> {
                    
                    if let categoryList = object["drinks"] {
                        for item in categoryList as! [Dictionary<String, String>] {

                            categories.append(item["strCategory"]!)
                        }
                    }
                }
                completion(categories)
            } catch {print(error.localizedDescription)}
            
        }.resume()
    }
    
    func fetchDrink(id: String, returnDrink: @escaping (Drink) -> ()) {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in

            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? Dictionary<String, AnyObject> {

                    if let item = object["drinks"]![0] as? Dictionary<String, AnyObject> {
                        var ingredientList = [(String, String)]()
                        ingredientList.append((item["strIngredient1"] as? String ?? "", item["strMeasure1"] as? String ?? ""))
                        ingredientList.append((item["strIngredient2"] as? String ?? "", item["strMeasure2"] as? String ?? ""))
                        ingredientList.append((item["strIngredient3"] as? String ?? "", item["strMeasure3"] as? String ?? ""))
                        ingredientList.append((item["strIngredient4"] as? String ?? "", item["strMeasure4"] as? String ?? ""))
                        ingredientList.append((item["strIngredient5"] as? String ?? "", item["strMeasure5"] as? String ?? ""))
                        ingredientList.append((item["strIngredient6"] as? String ?? "", item["strMeasure6"] as? String ?? ""))
                        ingredientList.append((item["strIngredient7"] as? String ?? "", item["strMeasure7"] as? String ?? ""))
                        ingredientList.append((item["strIngredient8"] as? String ?? "", item["strMeasure8"] as? String ?? ""))
                        ingredientList.append((item["strIngredient9"] as? String ?? "", item["strMeasure9"] as? String ?? ""))
                        ingredientList.append((item["strIngredient10"] as? String ?? "", item["strMeasure10"] as? String ?? ""))
                        ingredientList.append((item["strIngredient11"] as? String ?? "", item["strMeasure11"] as? String ?? ""))
                        ingredientList.append((item["strIngredient12"] as? String ?? "", item["strMeasure12"] as? String ?? ""))
                        ingredientList.append((item["strIngredient13"] as? String ?? "", item["strMeasure13"] as? String ?? ""))
                        ingredientList.append((item["strIngredient14"] as? String ?? "", item["strMeasure14"] as? String ?? ""))
                        ingredientList.append((item["strIngredient15"] as? String ?? "", item["strMeasure15"] as? String ?? ""))
                        let drink = Drink(id: item["idDrink"] as? String, name: item["strDrink"] as? String, tagList: item["strTags"] as? String, category: item["strCategory"] as? String, alcoholic: item["strAlcoholic"] as? String, glass: item["strGlass"] as? String, instructions: item["strInstructions"] as? String, image: item["strDrinkThumb"] as? String, creative: item["strCreativeCommonsConfirmed"] as? String, ingredients: ingredientList)
                        returnDrink(drink)
                    }
                }
            } catch {print(error.localizedDescription)}

        }.resume()
    }
    
    func fetchRandom(returnDrink: @escaping (Drink) -> ()) {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/random.php") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in

            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? Dictionary<String, AnyObject> {

                    if let item = object["drinks"]![0] as? Dictionary<String, AnyObject> {
                        var ingredientList = [(String, String)]()
                        ingredientList.append((item["strIngredient1"] as? String ?? "", item["strMeasure1"] as? String ?? ""))
                        ingredientList.append((item["strIngredient2"] as? String ?? "", item["strMeasure2"] as? String ?? ""))
                        ingredientList.append((item["strIngredient3"] as? String ?? "", item["strMeasure3"] as? String ?? ""))
                        ingredientList.append((item["strIngredient4"] as? String ?? "", item["strMeasure4"] as? String ?? ""))
                        ingredientList.append((item["strIngredient5"] as? String ?? "", item["strMeasure5"] as? String ?? ""))
                        ingredientList.append((item["strIngredient6"] as? String ?? "", item["strMeasure6"] as? String ?? ""))
                        ingredientList.append((item["strIngredient7"] as? String ?? "", item["strMeasure7"] as? String ?? ""))
                        ingredientList.append((item["strIngredient8"] as? String ?? "", item["strMeasure8"] as? String ?? ""))
                        ingredientList.append((item["strIngredient9"] as? String ?? "", item["strMeasure9"] as? String ?? ""))
                        ingredientList.append((item["strIngredient10"] as? String ?? "", item["strMeasure10"] as? String ?? ""))
                        ingredientList.append((item["strIngredient11"] as? String ?? "", item["strMeasure11"] as? String ?? ""))
                        ingredientList.append((item["strIngredient12"] as? String ?? "", item["strMeasure12"] as? String ?? ""))
                        ingredientList.append((item["strIngredient13"] as? String ?? "", item["strMeasure13"] as? String ?? ""))
                        ingredientList.append((item["strIngredient14"] as? String ?? "", item["strMeasure14"] as? String ?? ""))
                        ingredientList.append((item["strIngredient15"] as? String ?? "", item["strMeasure15"] as? String ?? ""))
                        let drink = Drink(id: item["idDrink"] as? String, name: item["strDrink"] as? String, tagList: item["strTags"] as? String, category: item["strCategory"] as? String, alcoholic: item["strAlcoholic"] as? String, glass: item["strGlass"] as? String, instructions: item["strInstructions"] as? String, image: item["strDrinkThumb"] as? String, creative: item["strCreativeCommonsConfirmed"] as? String, ingredients: ingredientList)
                        returnDrink(drink)
                    }
                }
            } catch {print(error.localizedDescription)}

        }.resume()
    }
       
    func fetchCategory(category: String, completion: @escaping ([String]) -> ()) {
        let categoryURL = category.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(categoryURL)") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in

            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                var drinks = [String]()
                if let object = json as? Dictionary<String, AnyObject> {
                    
                    if let categoryList = object["drinks"] {
                        for item in categoryList as! [Dictionary<String, String>] {
                            drinks.append(item["idDrink"]!)
                        }
                    }
                }
                completion(drinks)
            } catch {print(error.localizedDescription)}

        }.resume()
    }
}
