//
//  jokeViewController.swift
//  color-grid
//
//  Created by Admin on 5/18/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

struct Joke {
    let jokeText: String
    let jokeIcon: String
    
}

class JokeViewController: UIViewController {
    
    @IBOutlet weak var jokeImage: UIImageView!
    @IBOutlet weak var jokeLabel: UILabel!
    
    var joke: Joke?
    
    var currentJoke: String?
    var currentIcon: UIImage?
    
    var getJokeImage: UIImage?
    var getJokeText: String?
    var getJokeColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getJoke() {
            self.jokeLabel.text = self.currentJoke
            self.jokeImage.image = self.currentIcon
        }
        
        jokeLabel.textColor = UIColor.white

        
        print(currentJoke ?? "Nooooooo")
        
        
        view.layer.backgroundColor = getJokeColor!.cgColor
        
    }
    
    
    func getJoke(completion: @escaping ()->()) {
        let url = URL(string: "https://api.chucknorris.io/jokes/random?category=dev")!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let jokeData = data else {return}
            
            let json = try? JSONSerialization.jsonObject(with: jokeData, options: [])
            
            guard let jsonDictionary = json as? [String:Any] else {return}
            
            self.joke = Joke(jokeText: jsonDictionary["value"] as! String, jokeIcon: jsonDictionary["icon_url"] as! String)
            

            self.joke!.jokeIcon.downloadImage { (image) in
                DispatchQueue.main.async {
                    self.currentJoke = self.joke!.jokeText
                    self.currentIcon = image
                    completion()
                }
            }
        }.resume()
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

extension String {
    func downloadImage(completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: self) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            completion(UIImage(data: data))
        }.resume()
    }
}
