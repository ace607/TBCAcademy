//
//  LyricsViewController.swift
//  lyrics-app
//
//  Created by Admin on 5/19/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

struct Lyrics {
    let lyrics: String
}

class LyricsViewController: UIViewController {

    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var bandName: UILabel!
    @IBOutlet weak var songLyrics: UILabel!
    
    var band: String?
    var song: String?
    
    var lyrics: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songLyrics.text = "Loading lyrics.."
        getLyrics() {
            self.songLyrics.text = self.lyrics
        }
        // Do any additional setup after loading the view.
        songTitle.text = song
        bandName.text = band
    }
    
    func getLyrics(completion: @escaping ()->()) {
        let urlBand = self.band!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
        let urlSong = self.song!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
        

        let url = URL(string: "https://api.lyrics.ovh/v1/\(urlBand)/\(urlSong)")!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            guard let jsonDictionary = json as? [String:Any] else {return}
            
            self.lyrics = (jsonDictionary["lyrics"] as? String ?? "Lyrics not found in API :(")
            
            DispatchQueue.main.async {
                completion()
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
