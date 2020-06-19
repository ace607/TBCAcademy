//
//  OrderViewModel.swift
//  hw41
//
//  Created by Admin on 6/18/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation
import Localize

struct OrderViewModel {
    private let cd = CDManager()
    
    public var getOrders: [CoffeeOrder] {
        let orders = cd.fetchOrders()
        
        return orders
    }
}
