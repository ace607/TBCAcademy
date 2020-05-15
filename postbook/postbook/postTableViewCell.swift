//
//  postTableViewCell.swift
//  postbook
//
//  Created by Admin on 5/15/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class postTableViewCell: UITableViewCell {
    @IBOutlet weak var postUserImage: UIImageView!
    @IBOutlet weak var postUserName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postContent: UILabel!
    
    var userImage: UIImage?
    var postAuthor: String?
    var postCreationDate: String?
    var postText: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        postUserImage.image = userImage
        postUserName.text = postAuthor
        postDate.text = postCreationDate
        postContent.text = postText
        
        postUserImage.layer.cornerRadius = 30
    }

}
