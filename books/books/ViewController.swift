//
//  ViewController.swift
//  books
//
//  Created by Admin on 4/30/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, addBookProtocol {
    

    @IBOutlet weak var bookList: UITableView!
    
    var books = [book]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bookList.delegate = self
        bookList.dataSource = self
    }

    @IBAction func addBookPage(_ sender: UIButton) {
//        let addBookVC = addBookViewController()
//        addBookVC.delegate = self
//        present(addBookVC, animated: true, completion: nil)
        
        
        let storyboard = UIStoryboard(name : "Main" , bundle : nil)
        let addBookVC = storyboard.instantiateViewController(withIdentifier: "add_book")
        if let addBookPageVC = addBookVC as? addBookViewController{
            addBookPageVC.delegate = self
        }
        
        self.show(addBookVC, sender: true)
        print(books.count)
    }
    
    func addBookToList(bookItem: [book]) {
        books.append(contentsOf: bookItem)
        bookList.reloadData()
        print(books.count)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookList.dequeueReusableCell(withIdentifier: "book_item", for: indexPath) as! bookListTableViewCell

        cell.bookTitleLabel.text = books[indexPath.row].title
        cell.bookAuthorLabel.text = books[indexPath.row].author
        cell.BookPriceLabel.text = "$\(String(books[indexPath.row].price!))"
        cell.bookImageView.image = UIImage(named: books[indexPath.row].image ?? "")
        
        return cell
    }
}
