//
//  download_image.swift
//  hw46-music-app
//
//  Created by Admin on 6/23/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

extension String {
    func downloadImage(completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: self) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            completion(UIImage(data: data))
        }.resume()
    }
}
