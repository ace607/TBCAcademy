//
//  ViewController.swift
//  color-grid
//
//  Created by Admin on 5/18/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

struct UsersResponse: Codable {
    
    let colors: [Color]
    
    
    enum CodingKeys: String, CodingKey {
        case colors = "data"
    }
}

struct Color: Codable {
    let colorCodeHex: String
    let colorName: String
    var colorCode: String {
        var colorHex = colorCodeHex
        colorHex.remove(at: colorCodeHex.startIndex)
        return colorHex
    }
    
    
    enum CodingKeys: String, CodingKey {
        case colorName = "name"
        case colorCodeHex = "color"
    }
}

struct Joke {
    let jokeText: String
    let jokeIcon: String
    
}

class ViewController: UIViewController {
    
    var colors = [Color]()
    var joke: Joke?
    var currentJoke: String?
    var currentIcon: UIImage?
    var currentColor: UIColor?

    @IBOutlet weak var colorCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        colorCollection.delegate = self
        colorCollection.dataSource = self
        getColors()
        
        getJoke()
    }
    
    func getColors() {
        let url = URL(string: "https://reqres.in/api/unknown?")!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let usersResponse = try decoder.decode(UsersResponse.self, from: data)
                
                self.colors.append(contentsOf: usersResponse.colors)
                
                DispatchQueue.main.async {
                    self.colorCollection.reloadData()
                }
            } catch {print(error.localizedDescription)}
            
        }.resume()
    }
    
    
    func getJoke() {
        let url = URL(string: "https://api.chucknorris.io/jokes/random?category=dev")!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let jokeData = data else {return}
            
            let json = try? JSONSerialization.jsonObject(with: jokeData, options: [])
            
            guard let jsonDictionary = json as? [String:Any] else {return}
            
            self.joke = Joke(jokeText: jsonDictionary["value"] as! String, jokeIcon: jsonDictionary["icon_url"] as! String)
            
            self.currentJoke = self.joke!.jokeText

            self.joke!.jokeIcon.downloadImage { (image) in
                DispatchQueue.main.async {
                    self.currentIcon = image
                }
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "joke_segue" {
            if let jokeVC = segue.destination as? jokeViewController {
                getJoke()
                jokeVC.getJokeColor = currentColor
                jokeVC.getJokeImage = currentIcon
                jokeVC.getJokeText = currentJoke
            }
        }
    }
    

}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentColor = colors[indexPath.row].colorCodeHex.hexStringToUIColor()
        self.performSegue(withIdentifier: "joke_segue", sender: nil)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorCollection.dequeueReusableCell(withReuseIdentifier: "color_cell", for: indexPath) as! colorCollectionViewCell
        
        
        cell.colorCodeLabel.text = colors[indexPath.row].colorCode
        cell.colorNameLabel.text = colors[indexPath.row].colorName.capitalized
        
        cell.colorCodeLabel.textColor = UIColor.white
        cell.colorNameLabel.textColor = UIColor.white
        cell.colorNameLabel.alpha = 0.7
        cell.backgroundColor = colors[indexPath.row].colorCodeHex.hexStringToUIColor()
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.safeAreaLayoutGuide.layoutFrame.width / 2)
        let height = (view.safeAreaLayoutGuide.layoutFrame.height / 3)
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension String {
    func hexStringToUIColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func downloadImage(completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: self) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            completion(UIImage(data: data))
        }.resume()
    }
    
}
