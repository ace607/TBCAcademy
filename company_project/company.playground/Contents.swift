import Cocoa

class Company {
    var name: String { return  "" }
    var date: Int
    var headQuarter: String
    var founders: [String]
    
    init() {
        self.date = 2000
        self.headQuarter = "California"
        self.founders = ["Steve Jobs"]
    }
    
}

class Apple: Company {
    override var name: String { return "Apple" }
    
}

var apple1 = Apple()

apple1.name
