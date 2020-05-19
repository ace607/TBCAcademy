//
//  InfoViewController.swift
//  lyrics-app
//
//  Created by Admin on 5/19/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

struct UsersResponse: Codable {
    
    let bands: [songBand]
    
    enum CodingKeys: String, CodingKey {
        case bands = "data"
    }
}

struct songBand: Codable {
    let bandName: String
    let songTitles: Dictionary<String, String>
    
    
    enum CodingKeys: String, CodingKey {
        case bandName = "band"
        case songTitles = "songs"
    }
}

class InfoViewController: UIViewController {
    @IBOutlet weak var bandName: UILabel!
    @IBOutlet weak var bandImage: UIImageView!
    @IBOutlet weak var bandInfo: UILabel!
    
    @IBOutlet weak var songTable: UITableView!
    
    var band: Band?
    
    var songs = [String]()
    
    var clickedSong: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        songTable.delegate = self
        songTable.dataSource = self
        
//        
        bandName.text = band?.bandName
        bandInfo.text = band?.bandInfo
        band!.bandImage.downloadImage { (image) in
            DispatchQueue.main.async {
                self.bandImage.image = image
            }
        }
        getSongs()
        
    }

    func getSongs() {
        let url = URL(string: "http://www.mocky.io/v2/5ec3ca1c300000e5b039c407")!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonDictionary = json as? [String:Any] else {return}
                if let object = jsonDictionary["data"] as? [Dictionary<String, AnyObject>] {
                    for item in object {
                        if item["band"] as! String == self.band!.bandName {
                            if let songs = item["songs"] as? [Dictionary<String, AnyObject>] {
                                for song in songs {
                                    self.songs.append(song["title"] as! String)
                                }
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.songTable.reloadData()
                }
            } catch {print(error.localizedDescription)}
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "lyrics_segue" {
            if let lyricsVC = segue.destination as? LyricsViewController {
                lyricsVC.band = band?.bandName
                lyricsVC.song = clickedSong
            }
        }
    }

}

extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clickedSong = songs[indexPath.row]
        performSegue(withIdentifier: "lyrics_segue", sender: nil)
    }
    
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count > 0 ?  songs.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = songTable.dequeueReusableCell(withIdentifier: "song_cell", for: indexPath) as! SongTableViewCell
        
        if songs.count > 0 {
            cell.songTitle.text = songs[indexPath.row]
        } else {
            cell.songTitle.text = "No Songs"
        }
        
        return cell
    }
    
    
}
