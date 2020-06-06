//
//  APIServices.swift
//  news-app
//
//  Created by Admin on 6/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct Posts: Codable {
  let List: [PostInfo]
}
struct PostInfo: Codable {
  let Title  : String
  let Time  :String
  let Url   : String
//  let Type  : Int
  let PhotoUrl: String
  let PhotoAlt: String
}

struct randomText: Codable {
  let version : Int
  let text  :String
}

class APIResponse {
  func getPosts(completion: @escaping (Posts)->()){
      guard let url = URL(string: "http://www.mocky.io/v2/5ed9dd623300005b0079e689") else{return}
      URLSession.shared.dataTask(with: url){(data,res,err) in
      guard let data = data else{return}
      do{
        let decoder = JSONDecoder()
        let response = try decoder.decode(Posts.self, from: data)
        completion(response)
      }catch{print(error.localizedDescription)}
      }.resume()
    }
    
func getTexts(completion: @escaping (randomText)->()){
   guard let url = URL(string: "http://asdfast.beobit.net/api/") else{return}
   URLSession.shared.dataTask(with: url){(data,res,err) in
   guard let data = data else{return}
   do{
     let decoder = JSONDecoder()
     let response = try decoder.decode(randomText.self, from: data)
     completion(response)
   }catch{print(error.localizedDescription)}
   }.resume()
}


}
