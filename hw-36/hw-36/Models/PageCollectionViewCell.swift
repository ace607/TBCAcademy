//
//  PageCollectionViewCell.swift
//  hw-36
//
//  Created by Admin on 6/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var pageInfo: UILabel!
    
    func setupCell(for page: Page) {
        pageImage.image = page.img
        pageTitle.text = page.title
        pageInfo.text = page.info
    }
    
}
