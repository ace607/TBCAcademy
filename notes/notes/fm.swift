//
//  fm.swift
//  notes
//
//  Created by Admin on 5/8/20.
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
    
    func createFile(dir: String, text: String, id: Int) {
        let newPath = mainPath.appendingPathComponent("/\(dir)/note-\(id).txt")
        
        do {
            try text.write(to: newPath, atomically: true, encoding: .utf8)
        } catch let error {
            print(error)
        }
        
    }
    
    func noteList(dir: String) -> [URL] {
        let url = mainPath.appendingPathComponent(dir)
        do {
            return try fm.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles).sorted { $0.absoluteString.localizedStandardCompare($1.absoluteString) == .orderedAscending }
         } catch let error {
            print(error)
         }
        
         return []
    }
    
    func getNote(dir: String, at url: URL) -> String {
        do {
            return try String(contentsOf: url)
        } catch let error {
            return String(error.localizedDescription)
        }
    }
    
    func delete(dir: String, url: URL) {
        do {
            try fm.removeItem(at: url)
        } catch {
           
        }
    }
    
    func dirExists(dir: String) -> Bool {
        let url = mainPath.appendingPathComponent(dir)
        var isDirectory = ObjCBool(true)
        let exists = fm.fileExists(atPath: url.absoluteString, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
    
}
