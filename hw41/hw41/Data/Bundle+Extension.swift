//
//  Bundle+Extension.swift
//  hw41
//
//  Created by Admin on 6/17/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError()
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError()
        }
        
        return decoded
    }
}
