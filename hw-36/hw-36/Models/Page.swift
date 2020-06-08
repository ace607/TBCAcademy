//
//  Page.swift
//  hw-36
//
//  Created by Admin on 6/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation
import UIKit

struct Page {
    var imgName: String?
    var title: String?
    var info: String?
    var img: UIImage? {
        return UIImage(named: imgName!)
    }
}
