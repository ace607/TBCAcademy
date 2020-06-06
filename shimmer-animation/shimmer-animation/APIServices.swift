//
//  APIServices.swift
//  shimmer-animation
//
//  Created by Admin on 6/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class APIServices {
    
    typealias completion = ([Job]) -> ()
    
    func fetchJobs(completion: @escaping ([Job]) -> ()){
        guard let url = URL(string: "https://jobs.github.com/positions.json") else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                var jobs = [Job]()
                if let object = json as? [Dictionary<String, AnyObject>] {
                        for item in object {
                            let job = Job(id: item["id"] as? String ?? "", title: item["title"] as? String ?? "", photoURL: item["company_logo"] as? String ?? "", company: item["company"] as? String ?? "", type: item["type"] as? String ?? "", description: item["description"] as? String ?? "", url: item["url"] as? String ?? "", location: item["location"] as? String ?? "")
                            
                            jobs.append(job)
                        }
                }
                completion(jobs)
                
            } catch {print(error.localizedDescription)}
            
        }.resume()
    }
}
