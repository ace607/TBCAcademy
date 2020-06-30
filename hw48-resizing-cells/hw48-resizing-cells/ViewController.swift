//
//  ViewController.swift
//  hw48-resizing-cells
//
//  Created by Admin on 6/29/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [
        Movie(poster: UIImage(named: "1")!, title: "Breaking Bad", desc: "Mild-mannered high school chemistry teacher Walter White thinks his life can't get much worse. His salary barely makes ends meet, a situation not likely to improve once his pregnant wife gives birth, and their teenage son is battling cerebral palsy. But Walter is dumbstruck when he learns he has terminal cancer. Realizing that his illness probably will ruin his family financially, Walter makes a desperate bid to earn as much money as he can in the time he has left by turning an old RV into a meth lab on wheels."),
        Movie(poster: UIImage(named: "2")!, title: "Peaky Blinders", desc: "Britain is a mixture of despair and hedonism in 1919 in the aftermath of the Great War. Returning soldiers, newly minted revolutions and criminal gangs are fighting for survival in a nation rocked by economic upheaval. One of the most powerful gangs of the time is the Peaky Blinders, run by returning war hero Thomas Shelby and his family. But Thomas has bigger ambitions than just running the streets. When a crate of guns goes missing, he recognizes an opportunity to advance in the world because crime may pay but legitimate business pays better. Trying to rid Britain of its crime is Inspector Chester Campbell, who arrives from Belfast to try to achieve that goal."),
        Movie(poster: UIImage(named: "3")!, title: "Twin Peaks", desc: "A crime drama mixed with healthy doses of the surreal, this series is about FBI Agent Dale Cooper, who travels to the small logging town of Twin Peaks to solve the murder of seemingly innocent high schooler Laura Palmer. Almost nothing is as it seems, however, and the show's sometimes eerie visuals, oddball characters and wild dream sequences drive the point home."),
        Movie(poster: UIImage(named: "4")!, title: "The Leftovers", desc: "DescriptionIn a global cataclysm, \"The Sudden Departure,\" 140 million people disappeared without a trace. Three years later, residents of Mapleton, N.Y., try to maintain equilibrium when the notion of \"normal\" no longer applies. Intense grief has divided families and turned faith to cynicism, paranoia and madness, leading some of the traumatized to join the Guilty Remnant, a cultlike group. Kevin Garvey, a beleaguered police chief, must keep peace between townspeople and the cult, a task made tougher with concern about his kids. His daughter alternates between apathy and rebellion, and his wayward son befriends a charismatic prophet. \"The Leftovers\" is based on the best-seller by Tom Perrotta, who is one of the series' executive producers.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell
        
        selectedCell.isSelectedMovie = selectedCell.isSelectedMovie ? false : true
        
        selectedCell.movieText.text = selectedCell.isSelectedMovie ? movies[indexPath.row].desc : "Tap for details +"
        
        selectedCell.movieText.textColor = selectedCell.isSelectedMovie ? UIColor.black : UIColor.red
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie_cell", for: indexPath) as! MovieTableViewCell
        
        cell.moviePoster.image = movies[indexPath.row].poster
        
        cell.movieTitle.text = movies[indexPath.row].title
        cell.movieText.text = cell.isSelectedMovie ? movies[indexPath.row].desc : "Tap for details +"
        
        cell.movieText.textColor = cell.isSelectedMovie ? UIColor.black : UIColor.red
        
        return cell
    }
    
    
}
