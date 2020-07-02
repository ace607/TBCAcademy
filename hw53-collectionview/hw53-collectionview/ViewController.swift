//
//  ViewController.swift
//  hw53-collectionview
//
//  Created by Admin on 7/2/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let places: [Place] = [
        Place(img: UIImage(named: "image1")!, title: "Vestibulum eu", desc: "Sed lacinia commodo elementum. Nam quis facilisis augue."),
        Place(img: UIImage(named: "image2")!, title: "Maecenas mollis", desc: "Phasellus laoreet dui eget rhoncus volutpat."),
        Place(img: UIImage(named: "image3")!, title: "Maecenas tristique", desc: "Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."),
        Place(img: UIImage(named: "image4")!, title: "Etiam faucibus", desc: "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In vel libero purus."),
        Place(img: UIImage(named: "image5")!, title: "Pellentesque in", desc: "Integer auctor eros mauris, in convallis orci euismod non."),
        Place(img: UIImage(named: "image6")!, title: "Orci varius", desc: "Sed eget nunc vehicula, lobortis metus volutpat, convallis sem."),
        Place(img: UIImage(named: "image7")!, title: "Duis consectetur", desc: "Etiam in velit pharetra, cursus sem ut"),
        Place(img: UIImage(named: "image8")!, title: "Curabitur non", desc: "Duis bibendum quam sed augue laoreet efficitur. Mauris ac nisi mollis, rutrum diam nec, consectetur tellus."),
        Place(img: UIImage(named: "image9")!, title: "Class aptent", desc: "Mauris non lacus finibus, pharetra magna id, feugiat leo."),
        Place(img: UIImage(named: "image10")!, title: "Pellentesque", desc: "Nulla cursus molestie nunc, sed placerat quam viverra ac.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }


}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "place_cell", for: indexPath) as! PlaceCollectionViewCell
        
        cell.placePhoto.image = indexPath.section == 0 ? places[indexPath.row].img : places[indexPath.row * 2].img
        cell.placeTitle.text = indexPath.section == 0 ? places[indexPath.row].title : places[indexPath.row * 2].title
        cell.placeDesc.text = indexPath.section == 0 ? places[indexPath.row].desc : places[indexPath.row * 2].desc
        
        return cell
    }
    
    
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellImage = places[indexPath.row].img
        
        let width = self.view.frame.width / 2 - 40
        let height = width * cellImage.getRatio()
        
        return CGSize(width: width, height: height)
    }
}


extension UIImage {
    func getRatio() -> CGFloat {
        return self.size.width / self.size.height
    }
}
