//
//  ViewController.swift
//  shimmer-animation
//
//  Created by Admin on 6/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var jobTable: UITableView!
    @IBOutlet weak var refreshBtn: UIButton!
    
    private var isLoading = true
    let service = APIServices()
    
    var jobs = [Job]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        jobTable.delegate = self
        jobTable.dataSource = self
        
        refreshBtn.layer.cornerRadius = 25
        
        loadData()
        
    }
    @IBAction func onRefresh(_ sender: UIButton) {
        jobs.removeAll()
        isLoading = true
        jobTable.reloadData()
        loadData()
    }
    
    func loadData() {
        service.fetchJobs { (jobList) in
            self.jobs.append(contentsOf: jobList)
            
            DispatchQueue.main.async {
                self.jobTable.reloadData()
                self.jobTable.alpha = 0
                UIView.animate(withDuration: 5, animations: {
                    print("loaded")
                }) { (f) in
                    self.isLoading = false
                    
                    self.jobTable.reloadData()
                    UIView.animate(withDuration: 1) {
                        self.jobTable.alpha = 1
                    }
                }
            }
        }
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if jobs.count < 10 {
            return 10
        }
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jobTable.dequeueReusableCell(withIdentifier: "job_cell", for: indexPath) as! JobTableViewCell
        cell.isLoading(isLoading)
        if jobs.count > 0 {
            cell.jobTitle.text = jobs[indexPath.row].title
            cell.jobCompany.text = jobs[indexPath.row].company
            cell.jobLocation.text = jobs[indexPath.row].location
            cell.jobType.text = jobs[indexPath.row].type
            
            let url = URL(string: jobs[indexPath.row].photoURL!)
            cell.jobPhoto.kf.setImage(with: url)
            
        }
        
        
        
        return cell
    }
    
    
}
