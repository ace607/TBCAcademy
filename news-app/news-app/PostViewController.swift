//
//  PostViewController.swift
//  news-app
//
//  Created by Admin on 6/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postText: UILabel!
    
    var tempText: String?
    
    var currentPost: PostInfo?
    
    var response = APIResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        response.getTexts { (randomText) in
            self.tempText = randomText.text
            
            DispatchQueue.main.async {
                self.postText.text = self.tempText
            }
        }
        
        postTitle.text = currentPost?.Title
        postTime.text = currentPost?.Time
        let url = URL(string: currentPost!.PhotoUrl)
        postImage.kf.setImage(with: url)
    }
    

    @IBAction func onBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
