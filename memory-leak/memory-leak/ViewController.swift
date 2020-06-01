//
//  ViewController.swift
//  memory-leak
//
//  Created by Admin on 6/1/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        var sandro: Person?
        var developer: Job?
        
        sandro = Person()
        developer = Job()
        
        sandro?.job = developer
        developer?.person = sandro
        
        sandro = nil
        developer = nil
        
    }
}
 
class Job {
    weak var person: Person?
    
    deinit {
        print("Deallocating Job")
    }
}

class Person {
    var job: Job?
    
    deinit {
        print("Deallocating Person")
    }
}


//  პრობლემა გვაქვს Strong Reference Cycle-თან, ამ კლასების ინსტანსები ერთმანეთთან დაკავშირებულია strong reference-ით, რის გამოც რეფერენსების რაოდენობა არ ნულდება როცა ამ ობიექტებს ვუტოლებთ nil-ს და ARC ვერ ახდენს ამ ინსტანსების დეალოკაციას. იმისთვის რომ ARC-მა შეძლოს ინსტანსების დეალოკაცია, საჭიროა რომ ამ ობიექტებს შორის არ იყოს strong რეფეერენსი. იმისთვის რომ გადავჭრათ ეს პრობლემა, job კლასში person ობიექტზე მიმთითებელი უნდა განვსაზღვროთ weak keyword-ით, ამ შემთხვევაში არ გვექნება strong რეფერენსი და ობიექტების nil-სთვის გატოლებისას რეფერენსების რაოდენობა განულდება და ARC მოახდენს ამ ინსტანსების დეალოკაციას, რის შედეგადაც გამოიძახება deinit ფუნქცია.

