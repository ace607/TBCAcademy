//
//  ViewController.swift
//  everyday-tasks
//
//  Created by Admin on 6/2/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var taskTable: UITableView!
    
    var tasks = [
        (title: "Do loundry", h: 9, m: 00),
        (title: "Wash Dishes", h: 12, m: 30),
        (title: "Workout", h: 7, m: 50),
        (title: "Attend TBC Lecture", h: 10, m: 00),
        (title: "Do Homework", h: 14, m: 50),
        (title: "Run", h: 19, m: 30),
        (title: "Eat Dinner", h: 15, m: 5),
        (title: "Desert", h: 15, m: 30),
        (title: "HHHHH", h: 15, m: 32),
        (title: "AAAAA", h: 15, m: 33),
        (title: "AAAAA", h: 15, m: 34)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTable.delegate = self
        taskTable.dataSource = self
        
        getAccess()
        
        tasks.sort { (a, b) -> Bool in
            return a.h == b.h ? a.m < b.m : a.h < b.h
        }
        
        taskTable.reloadData()
        
        let center = UNUserNotificationCenter.current()
        
        
        for item in tasks {
            
            let id = (item.title.map { char in
                String(char.asciiValue!)
            }).joined() + String(item.h) + String(item.m)
            
            center.getPendingNotificationRequests { (reqs) in
                
                var ids = [String]()
                
                for notification in reqs {
                    
                    ids.append(notification.identifier)
                    
                    
                }
                
                if !ids.contains(id) {
                    let content = UNMutableNotificationContent()
                    content.title = "Everyday Tasks"
                    content.body = "Now: \(item.title)"
                    content.sound = UNNotificationSound.default

                    var dateComponents = DateComponents()
                    dateComponents.hour = item.h
                    dateComponents.minute = item.m

                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    

                    print(id)
                    let req = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                    center.add(req)
                }
            }
            
        }
        
    }

    func getAccess() {
        let center = UNUserNotificationCenter.current()
        
        
        
        center.getNotificationSettings { (settings) in
            
            if settings.authorizationStatus == .denied {
                DispatchQueue.main.async {
                    self.showLetterAboutPermissionDenied()
                }
            } else {
                DispatchQueue.main.async {
                    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, err) in
                        if !granted {
                            DispatchQueue.main.async {
                                self.showLetterAboutPermissionDenied()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func showLetterAboutPermissionDenied() {
        let alert = UIAlertController(title: "Warning", message: "In order to get notifications about tasks, you have to allow notifications for this app.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) in
            self.openAppSettings()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    private func openAppSettings() {
        if let url = URL(string:UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTable.dequeueReusableCell(withIdentifier: "task_cell", for: indexPath) as! TaskTableViewCell
        
        cell.taskTitle.text = tasks[indexPath.row].title
        cell.taskTime.text = "\(String(format: "%02d", tasks[indexPath.row].h)):\(String(format: "%02d", tasks[indexPath.row].m))"
        
        return cell
    }
    
    
}
