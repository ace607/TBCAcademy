//
//  addBookViewController.swift
//  books
//
//  Created by Admin on 4/30/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

protocol addBookProtocol {
    func addBookToList(bookItem: [book])
}

class addBookViewController: UIViewController {

    @IBOutlet weak var bookTitleField: UITextField!
    @IBOutlet weak var bookAuthorField: UITextField!
    @IBOutlet weak var bookPriceField: UITextField!
    
    var delegate: addBookProtocol?
    
    let images = ["gatsby_image", "harry_potter_image", "shining_image", "lotr_image"]
    
    var books = [book]()
    
    
    @IBOutlet weak var addBookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookTitleField.setLeftPaddingPoints(25)
        bookTitleField.setRightPaddingPoints(25)
        bookTitleField.layer.cornerRadius = 25
        bookAuthorField.setLeftPaddingPoints(25)
        bookAuthorField.setRightPaddingPoints(25)
        bookAuthorField.layer.cornerRadius = 25
        bookPriceField.setLeftPaddingPoints(25)
        bookPriceField.setRightPaddingPoints(25)
        bookPriceField.layer.cornerRadius = 25
        
        addBookButton.layer.cornerRadius = 25
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func addBookTapped(_ sender: UIButton) {
        if bookTitleField.text == "" || bookAuthorField.text == "" || bookPriceField.text == "" {
            showAlert(title: "Error", message: "Please, fill all fields.")
        } else if Int(bookPriceField.text!) == nil {
            showAlert(title: "Error", message: "Age must be an integer!!!.")
        } else {
            let randomImage = images[Int.random(in: 0...3)]
            let newBook = book(title: bookTitleField.text!, author: bookAuthorField.text!, price: Int(bookPriceField.text!)!, image: randomImage)
            books.append(newBook)
            self.delegate?.addBookToList(bookItem: books)
            self.dismiss(animated: true, completion: nil)

        }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
