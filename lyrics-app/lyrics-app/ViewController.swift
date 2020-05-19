//
//  ViewController.swift
//  lyrics-app
//
//  Created by Admin on 5/19/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

struct Band {
    let bandName: String
    let bandImage: String
    let bandInfo: String
}

class ViewController: UIViewController {

    @IBOutlet weak var bandCollection: UICollectionView!
    
    var bands = [Band]()
    
    var clickedBand: Band?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bandCollection.delegate = self
        bandCollection.dataSource = self
        
        getBands()
    }
    
    
    func getBands() {
        let url = URL(string: "http://www.mocky.io/v2/5ec3ab0f300000850039c29e")!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            do {
                
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [Any] {
                    for anItem in object as! [Dictionary<String, AnyObject>] {
                        let bandName = anItem["name"] as! String
                        let bandImage = anItem["img_url"] as! String
                        let bandInfo = anItem["info"] as! String
                        let band = Band(bandName: bandName, bandImage: bandImage, bandInfo: bandInfo)
                        self.bands.append(band)
                    }
                }
                
                DispatchQueue.main.async {
                    self.bandCollection.reloadData()
                }
            } catch {print(error)}
            
        }.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "band_info_segue" {
            if let infoVC = segue.destination as? InfoViewController {
                infoVC.band = clickedBand
            }
        }
    }

}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.clickedBand = bands[indexPath.row]
        performSegue(withIdentifier: "band_info_segue", sender: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bandCollection.dequeueReusableCell(withReuseIdentifier: "band_cell", for: indexPath) as! BandCollectionViewCell
        
        cell.bandName.text = bands[indexPath.row].bandName
//        cell.bandImage.frame = CGRect(x: 0, y: 0, width: cell.frame.height, height: cell.frame.height - 50)
        
        
        self.bands[indexPath.row].bandImage.downloadImage { (image) in
            DispatchQueue.main.async {
                cell.bandImage.image = image
            }
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.safeAreaLayoutGuide.layoutFrame.width / 2) - 15
        let height = width
        
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
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
