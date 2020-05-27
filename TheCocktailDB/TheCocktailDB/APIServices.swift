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
    typealias returnIngredient = (Ingredient) -> ()
    
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
    
    func fetchIngredients(completion: @escaping ([String]) -> ()){
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                var ingredients = [String]()
                if let object = json as? Dictionary<String, AnyObject> {
                    
                    if let ingredientList = object["drinks"] {
                        for item in ingredientList as! [Dictionary<String, String>] {

                            ingredients.append(item["strIngredient1"]!)
                        }
                    }
                }
                completion(ingredients)
            } catch {print(error.localizedDescription)}
            
        }.resume()
    }
    
    func fetchIngredient(name: String, returnIngredient: @escaping (Ingredient) -> ()) {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?i=\(name)") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in

            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? Dictionary<String, AnyObject> {

                    if let item = object["ingredients"]![0] as? Dictionary<String, AnyObject> {
                        let ingredient = Ingredient(id: item["idIngredient"] as? String ?? "", name: item["strIngredient"] as? String ?? "", description: item["strDescription"] as? String ?? "", type: item["strType"] as? String ?? "", alcoholic: item["strAlcohol"] as? String ?? "", alcVolume: item["strABV"] as? String ?? "")
                        returnIngredient(ingredient)
                    }
                }
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
    
    func fetchByIngredient(ingredient: String, completion: @escaping ([String]) -> ()) {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(ingredient)") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in

            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                var drinks = [String]()
                if let object = json as? Dictionary<String, AnyObject> {
                    
                    if let drinkList = object["drinks"] {
                        for item in drinkList as! [Dictionary<String, String>] {
                            drinks.append(item["idDrink"]!)
                        }
                    }
                }
                completion(drinks)
            } catch {print(error.localizedDescription)}

        }.resume()
    }
    
    func fetchSearch(text: String, completion: @escaping ([Drink]) -> ()) {
        let searchText = text.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(searchText)") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in

            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                var drinks = [Drink]()
                if let object = json as? Dictionary<String, AnyObject> {
                    if let list = object["drinks"] as? [Dictionary<String, AnyObject>] {
                    for item in list  {
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
                        drinks.append(drink)
                    }
                    }
                    completion(drinks)
                }
            } catch {print(error.localizedDescription)}

        }.resume()
    }
}
