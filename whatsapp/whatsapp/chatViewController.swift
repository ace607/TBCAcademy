//
//  chatViewController.swift
//  whatsapp
//
//  Created by Admin on 5/7/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class chatViewController: UIViewController, newMessage {
    
    

    @IBOutlet weak var chatTable: UITableView!
    
    var chatList = [chatItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        chatTable.delegate = self
        chatTable.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createNewMessage(item: chatItem) {
        chatList.append(item)
        chatTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "add_message_Segue" {
            if let addMessageVC = segue.destination as? newMessageViewController {
                addMessageVC.createMessage = self
            }
        }
    }

}

struct chatItem {
    var image: UIImage
    var name: String
    var message: String
}

extension chatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "chat_details")
        
        if let detailsView = detailsVC as? chatDetailsViewController {
            detailsView.getChatImage = chatList[indexPath.row].image
            detailsView.getChatName = chatList[indexPath.row].name
            detailsView.getChatMesage = chatList[indexPath.row].message
        }
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

extension chatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTable.dequeueReusableCell(withIdentifier: "chat_item", for: indexPath) as! chatTableViewCell
        
        cell.chatImage.image  = chatList[indexPath.row].image
        cell.chatName.text = chatList[indexPath.row].name
        cell.chatText.text = chatList[indexPath.row].message
        
        
        return cell
    }
    
    
}
