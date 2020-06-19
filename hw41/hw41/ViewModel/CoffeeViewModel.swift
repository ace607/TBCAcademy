//
//  CoffeeViewModel.swift
//  hw41
//
//  Created by Admin on 6/17/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit


struct CoffeeViewModel {
    private let coffeeData: CoffeeList = Bundle.main.decode(file: "coffee_data.json")
    
    public var getCoffees: [Coffee] {
        let coffeeViewModels = coffeeData.list
        
        return coffeeViewModels
    }
}
