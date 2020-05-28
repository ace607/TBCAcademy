//
//  CDServices.swift
//  TheCocktailDB
//
//  Created by Admin on 5/27/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CDServices {
    func fetchCurrentUser() -> User {
        
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            var currentUser = User()
            for user in result {
                if user.username == UDManager.getUser() {
                    currentUser = user
                }
            }
            
            return currentUser
        } catch {
            print("ERROR: Couldn't fetch podcasts")
        }
        return User()
    }
    
    func fetchUsers() -> [User] {
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let users = result as [User]
            
            return users
        } catch {
            print("ERROR: Couldn't fetch users")
        }
        
        return []
    }
    
    func addUser(username: String, firstname: String, lastname: String, email: String, password: String) {
        
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let user = User(entity: entityDescription!, insertInto: context)
        
        user.username = username
        user.email = email
        user.firstname = firstname
        user.lastname = lastname
        user.password = password

        do {
            try context.save()
        } catch {
            
        }

      
    }
    
    func addToFavorites(_ id: String) {
        
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescriptionFavorite = NSEntityDescription.entity(forEntityName: "Favorite", in: context)
        
        var user: User?
        
        for userMatch in fetchUsers() {
            if userMatch.username == UDManager.getUser() {
                user = userMatch
            }
        }
        let favorite = Favorite(entity: entityDescriptionFavorite!, insertInto: context)
        
        favorite.id = id
        favorite.user = user
        favorite.date = Date()

        do {
            try context.save()
        } catch {
            
        }
    }
    
    
    func getFavorites() -> [Favorite] {
        
        var user: User?
        
        for userMatch in fetchUsers() {
            if userMatch.username == UDManager.getUser() {
                user = userMatch
            }
        }
        for item in ((user!.favorites?.allObjects as NSArray?) as! [Favorite]).sorted(by: { ($0.date!).compare($1.date!) == .orderedDescending }) {
            print(item.id)
        }
        
        return ((user!.favorites?.allObjects as NSArray?) as! [Favorite]).sorted(by: { ($0.date!).compare($1.date!) == .orderedDescending })
    }
    
    func removeFavorite(favorite: Favorite) {
        let context = AppDelegate.coreDataContainer.viewContext
        context.delete(favorite)
        do {
            try context.save()
        } catch {
            
        }
    }
}
