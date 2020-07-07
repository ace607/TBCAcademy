//
//  APIService.swift
//  hw54-carousel
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class APIService {
    
    
    static func fetchCharacters(completion: @escaping ([Character]) -> ()) {
        
        guard let url = URL(string: "https://www.breakingbadapi.com/api/characters") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode([Character].self, from: data)

                completion(characters)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}
