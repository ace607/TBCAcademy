import Cocoa

class Company {
    var name: String
    var date: Int
    var headQuarter: String
    var founders: [String]
    var products: [String]

    init(name: String, date: Int, headQuarter: String, founders: [String], products: [String] = ["No Products"] ) {
        self.name = name
        self.date = date
        self.headQuarter = headQuarter
        self.founders = founders
        self.products = products
    }
    
    func printName() {
        print(self.name)
    }
    
    func printDate() {
        print(self.date)
    }
    
    func printHeadQuarter() {
        print(self.headQuarter)
    }
    
    func printFounders() {
        print(self.founders.joined(separator: ", "))
    }
    
    func printProducts() {
        print(self.products.joined(separator: ", "))
    }
}

class Apple: Company {
    init() {
        super.init(name: "Apple", date: 1976, headQuarter: "Cupertino, California", founders: ["Steve Jobs", "Steve Wozniak", "Ronald Wayne"],
                   products: ["iPhone X", "Macbook Air", "Swift"])
    }
}

class Google: Company {
    init() {
        super.init(name: "Google", date: 1998, headQuarter: "Mountain View, California", founders: ["Larry Page", "Sergey Brin"],
        products: ["Android", "Pixel", "Chrome"])
    }
}

class Facebook: Company {
    init() {
        super.init(name: "Facebook", date: 2004, headQuarter: "Menlo Park, California", founders: ["Mark Zuckerberg", "Steve Wozniak", "Ronald Wayne"],
        products: ["Messenger", "Instagram"])
    }
}

var apple = Apple()

apple.printName()
apple.printDate()
apple.printHeadQuarter()
apple.printFounders()
apple.printProducts()
print("-----")

var facebook = Facebook()

facebook.printName()
facebook.printDate()
facebook.printHeadQuarter()
facebook.printFounders()
facebook.printProducts()
print("-----")


var google = Google()

google.printName()
google.printDate()
google.printHeadQuarter()
google.printFounders()
google.printProducts()
