//
//  HistoryViewController.swift
//  guess-number
//
//  Created by Admin on 5/22/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        historyTable.delegate = self
        historyTable.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HistoryViewController: UITableViewDelegate {
    
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResults().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: "history_cell", for: indexPath) as! HistoryTableViewCell
        
        cell.resultLabel.text = fetchResults()[indexPath.row].text
        cell.numLabel.text = fetchResults()[indexPath.row].resultNum
        
        return cell
    }
    
    
}

extension HistoryViewController {
    
    func fetchResults() -> [Result] {
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<Result> = Result.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            var results = result as [Result]
            results = results.sorted(by: { $0.date!.compare($1.date!) == .orderedDescending })
            
            return results
        } catch {
            print("ERROR: Couldn't fetch podcasts")
        }
        
        return []
    }
}
