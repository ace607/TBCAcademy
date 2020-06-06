//
//  ViewController.swift
//  news-app
//
//  Created by Admin on 6/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var postsTable: UITableView!
    
    let service = APIResponse()
    
    var postList = [PostInfo]()
    
    var selectedPost: PostInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        postsTable.delegate = self
        postsTable.dataSource = self
        
        service.getPosts { (posts) in
            self.postList = posts.List
            DispatchQueue.main.async {
                self.postsTable.reloadData()
            }
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_post" {
            if let detailsVC = segue.destination as? PostViewController {
                detailsVC.currentPost = self.selectedPost
            }
        }
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPost = postList[indexPath.row]
        performSegue(withIdentifier: "show_post", sender: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTable.dequeueReusableCell(withIdentifier: "post_cell", for: indexPath) as! PostTableViewCell
        
        cell.postTitle.text = postList[indexPath.row].Title
        cell.postTime.text = postList[indexPath.row].Time
        let url = URL(string: postList[indexPath.row].PhotoUrl)
        cell.postImage.kf.setImage(with: url)
        
        
        return cell
    }
    
    
}
