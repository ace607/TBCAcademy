//
//  ViewController.swift
//  hw54-carousel
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var charactersCollection: UICollectionView!
    
    var characters = [Character]()
    
    var selectedCharacter: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        charactersCollection.delegate = self
        charactersCollection.dataSource = self
        charactersCollection.backgroundColor = .clear
        
        charactersCollection.register(UINib.init(nibName: "CharactersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "character_cell")
        
        
        // https://www.youtube.com/watch?v=1Qn4cSlO5hE&feature=youtu.be
        // https://github.com/ink-spot/UPCarouselFlowLayout
        
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.bounds.size.width - 150, height: charactersCollection.frame.size.height/1.7)
        flowLayout.scrollDirection = .vertical
        flowLayout.sideItemScale = 0.6
        flowLayout.sideItemAlpha = 0.5
        flowLayout.spacingMode = .fixed(spacing: 5.0)
        charactersCollection.collectionViewLayout = flowLayout
        
        APIService.fetchCharacters { (characters) in
            self.characters = characters
            
            DispatchQueue.main.async {
                self.charactersCollection.reloadData()
            }
        }
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_details" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.selectedCharacter = selectedCharacter
            }
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCharacter = characters[indexPath.row]
        performSegue(withIdentifier: "show_details", sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = charactersCollection.dequeueReusableCell(withReuseIdentifier: "character_cell", for: indexPath) as! CharactersCollectionViewCell

            cell.name.text = characters[indexPath.row].name
            
            characters[indexPath.row].img.downloadImage { (img) in
                DispatchQueue.main.async {
                    cell.img.image = img
                }
            }
        
        return cell
    }
    
}

