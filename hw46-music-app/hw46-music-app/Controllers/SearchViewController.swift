//
//  SearchViewController.swift
//  hw46-music-app
//
//  Created by Admin on 6/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tracksTable: UITableView!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var albumsCollection: UICollectionView!
    
    let service = APIServices()
    
    var searchList = [Track]()
    
    var albumList = [AlbumSearchObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tracksTable.delegate = self
        tracksTable.dataSource = self
        
        albumsCollection.delegate = self
        albumsCollection.dataSource = self
        
        tracksTable.register(UINib(nibName: "SearchTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "search_cell")
        albumsCollection.register(UINib(nibName: "SearchAlbumCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "album_search_cell")
        
        searchField.layer.cornerRadius = 27
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 47, height: 54))
        
        let searchIcon = UIImageView(image: UIImage(named: "search-icon"))
        searchIcon.frame = CGRect(x: leftView.center.x - 8.5, y: leftView.center.y - 12, width: searchIcon.frame.width, height: searchIcon.frame.height)
        
        leftView.addSubview(searchIcon)
        
        
        searchField.leftViewMode = .always
        searchField.leftView = leftView
        searchField.leftView?.contentMode = .center
        
        resultsView.alpha = searchField.text == "" ? 0 : 1
        
    }
    
    func search(query: String) {
        service.fetchSearch(query: query) { (playlist) in
            self.searchList = playlist.data
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tracksTable.reloadData()
            }
        }
        service.fetchAlbumSearch(query: query) { (albums) in
            self.albumList = albums.data
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.albumsCollection.reloadData()
            }
        }
    }
    @IBAction func textDidChange(_ sender: UITextField) {
        
        if searchField.text == "" {
            UIView.animate(withDuration: 0.3) {
                self.resultsView.alpha = 0
            }
        } else {
            search(query: sender.text!)
            UIView.animate(withDuration: 0.3) {
                self.resultsView.alpha = 1
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count > 3 ? 3 : searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tracksTable.dequeueReusableCell(withIdentifier: "search_cell", for: indexPath) as! SearchTableViewCell
        
        cell.trackName.text = searchList[indexPath.row].title
        cell.trackArtist.text = searchList[indexPath.row].artist.name
        
        searchList[indexPath.row].album.cover.downloadImage { (img) in
            DispatchQueue.main.async {
                cell.trackImg.image = img!
            }
        }
        
        return cell
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumList.count > 10 ? 10 : albumList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumsCollection.dequeueReusableCell(withReuseIdentifier: "album_search_cell", for: indexPath) as! SearchAlbumCollectionViewCell
        
        cell.albumTitle.text = albumList[indexPath.row].title
        cell.albumArtist.text = albumList[indexPath.row].artist.name

        albumList[indexPath.row].cover.downloadImage { (img) in
            DispatchQueue.main.async {
                cell.albumImg.image = img!
            }
        }
        
        
        return cell
    }
    
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 232)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
