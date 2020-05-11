//
//  fm.swift
//  file-manager
//
//  Created by Admin on 5/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class CustomFM {
    let fm = FileManager.default
    
    static let cmf = CustomFM()
    
    private init() {}
    
    var mainPath: URL {
        return try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    static func defaultManager() -> CustomFM {
        return cmf
    }
    
    func createDirectory(name: String) {
        let newPath = mainPath.appendingPathComponent(name)
        
        do {
            try fm.createDirectory(at: newPath, withIntermediateDirectories: false, attributes: nil)
        } catch let error {
            print(error)
        }
    }
    
    func createFile(dir: String, text: String, name: String) {
        let newPath = mainPath.appendingPathComponent("\(dir)/\(name).txt")
        
        do {
            try text.write(to: newPath, atomically: true, encoding: .utf8)
        } catch let error {
            print(error)
        }
        
    }
    
    func folderList() -> [URL] {
        do {
            return try fm.contentsOfDirectory(at: mainPath, includingPropertiesForKeys: nil, options: .skipsHiddenFiles).sorted { $0.absoluteString.localizedStandardCompare($1.absoluteString) == .orderedAscending }
         } catch let error {
            print(error)
         }
        
         return []
    }
    
    func fileList(dir: String) -> [URL] {
        let url = mainPath.appendingPathComponent(dir)
        do {
            return try fm.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles).sorted { $0.absoluteString.lowercased().localizedStandardCompare($1.absoluteString.lowercased()) == .orderedAscending }
         } catch let error {
            print(error)
         }
        
         return []
    }
    
    
    func readFile(dir: String, name: String) -> String {
        let url = mainPath.appendingPathComponent("\(dir)/\(name)")
        do {
            return try String(contentsOf: url)
        } catch let error {
            return String(error.localizedDescription)
        }
    }
    
    
    func deleteFile(url: URL) {
        do {
            try fm.removeItem(at: url)
        } catch {
            print("couldn't delete")
        }
    }
    
    func dirExists(dir: String) -> Bool {
        let url = mainPath.appendingPathComponent(dir)
        let isDir = (try? url.resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory
        return isDir ?? false
    }
    
    func fileExists(dir: String, name: String) -> Bool {
        let url = mainPath.appendingPathComponent("\(dir)/\(name).txt")
        let fileExists = fm.fileExists(atPath: url.path)
        return fileExists
    }
    
}
