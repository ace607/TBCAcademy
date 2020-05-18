//
//  jokeViewController.swift
//  color-grid
//
//  Created by Admin on 5/18/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class jokeViewController: UIViewController {
    
    @IBOutlet weak var jokeImage: UIImageView!
    @IBOutlet weak var jokeLabel: UILabel!
    
    
    var getJokeImage: UIImage?
    var getJokeText: String?
    var getJokeColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        jokeImage.image = getJokeImage
        jokeLabel.text = getJokeText
        jokeLabel.textColor = UIColor.white
        
        view.layer.backgroundColor = getJokeColor!.cgColor
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
