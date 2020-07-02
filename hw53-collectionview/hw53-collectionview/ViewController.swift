//
//  ViewController.swift
//  hw53-collectionview
//
//  Created by Admin on 7/2/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

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
    
    var selectedPlace: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let layout = collectionView?.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        for item in places {
            addPlaces(title: item.title, image: item.img, desc: item.desc)
        }
        
        collectionView.reloadData()
    }
    
    
    private func fetchPlaces() -> [PlaceModel] {
        
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<PlaceModel> = PlaceModel.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let places = result as [PlaceModel]
            
            return places
        } catch {
            print("ERROR: Couldn't fetch podcasts")
        }
        
        return []
        
    }
    
    private func addPlaces(title: String, image: UIImage, desc: String) {
        
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "PlaceModel", in: context)
        
        if fetchPlaces().contains(where: { $0.title == title && image.pngData()! == $0.img! && $0.desc == desc }) { return }
        
        let place = PlaceModel(entity: entityDescription!, insertInto: context)
        
        place.title = title
        
        if let binaryImage = image.pngData() {
            place.img = binaryImage
        }
        
        place.desc = desc
        
        do {
            try context.save()
        } catch {
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_details" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.place = selectedPlace!
            }
        }
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selected = fetchPlaces()[indexPath.row]
        
        self.selectedPlace = Place(img: UIImage(data: selected.img!)!, title: selected.title!, desc: selected.desc!)
        performSegue(withIdentifier: "show_details", sender: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchPlaces().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "place_cell", for: indexPath) as! PlaceCollectionViewCell
        
        cell.placePhoto.image = UIImage(data: fetchPlaces()[indexPath.row].img!)
        cell.placeTitle.text = fetchPlaces()[indexPath.row].title
        cell.placeDesc.text = fetchPlaces()[indexPath.row].desc
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        
        return CGSize(width: itemSize, height: itemSize + 60)
    }
    
}

extension UIImage {
    func getRatio() -> CGFloat {
        return self.size.height / self.size.width
    }
}

extension ViewController: CustomLayoutDelegate {
    func collectionView( _ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        let cellImage = UIImage(data: fetchPlaces()[indexPath.row].img!)!
        
        let height = itemSize * cellImage.getRatio() + 60
        return height
    }
    
    
}
