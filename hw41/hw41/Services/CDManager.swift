//
//  addOrder.swift
//  hw41
//
//  Created by Admin on 6/18/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation
import CoreData

class CDManager {
    func addOrder(coffee: Coffee, count: Int, sugar: Int, size: String) {
        
        
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "CoffeeOrder", in: context)
        
        for _ in 0..<count {
            let order = CoffeeOrder(entity: entityDescription!, insertInto: context)
            
            order.name = coffee.name
            order.size = size
            order.sugar = Int16(sugar)
            order.price = coffee.price
            order.date = Date()
        }
        do {
            try context.save()
        } catch {
            
        }
        
    }
    
    func fetchOrders() -> [CoffeeOrder] {
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<CoffeeOrder> = CoffeeOrder.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            let orders = result as [CoffeeOrder]
            
            return orders
        } catch {
            print("ERROR: Couldn't fetch orders")
        }
        
        return []
    }
    
}
