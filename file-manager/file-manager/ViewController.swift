//
//  ViewController.swift
//  file-manager
//
//  Created by Admin on 5/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, newFolder {
    

    @IBOutlet weak var folderList: UICollectionView!
    
    let newFileManager = CustomFM.defaultManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        folderList.delegate = self
        folderList.dataSource = self
        
    }

    func createFolder(name: String) {
        newFileManager.createDirectory(name: name)
        folderList.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "add_folder_segue" {
            if let addFolderVC = segue.destination as? addFolderViewController {
                addFolderVC.createFolderDelegate = self
            }
        }
    }

}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "folder_details_vc")
        
        if let detailsView = detailsVC as? folderDetailsViewController {
//            detailsView.noteTextContent = newFileManager.getNote(dir: directory, at: newFileManager.noteList(dir: directory)[indexPath.row])
            detailsView.title = newFileManager.folderList()[indexPath.row].lastPathComponent
            detailsView.currentFolder = newFileManager.folderList()[indexPath.row].lastPathComponent
        }
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newFileManager.folderList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = folderList.dequeueReusableCell(withReuseIdentifier: "folder_cell", for: indexPath) as! folderCollectionViewCell
        if let myImage = UIImage(named: "folder") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            cell.folderIcon.image = tintableImage
        }
        
        cell.folderIcon.tintColor = UIColor(red: 250/255, green: 202/255, blue: 51/255, alpha: 1)
        
        cell.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 0.3)
        cell.layer.cornerRadius = 10
        
        cell.folderName.text =  newFileManager.folderList()[indexPath.row].lastPathComponent
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width / 2) - 40
        return CGSize(width: itemWidth, height: 128)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
