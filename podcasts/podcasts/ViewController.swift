//
//  ViewController.swift
//  podcasts
//
//  Created by Admin on 5/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, addPodcast, filterPodcasts {
  
    @IBOutlet weak var podcastTable: UITableView!
    
    var filterTime: Int16?
    
    var selectedMinFilter = 0
    var selectedSecFilter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        podcastTable.delegate = self
        podcastTable.dataSource = self
        
    }
    
    func addNewPodcast(title: String, desc: String, length: Int16) {
        addPodcast(title: title, desc: desc, length: length)
        podcastTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "add_podcast_segue" {
            if let addVC = segue.destination as? addPodcastViewController {
                addVC.addPodcastDelegate = self
            }
        }
        
        if let identifier = segue.identifier, identifier == "filter_podcasts_segue" {
            if let filterVC = segue.destination as? filterPodcastsViewController {
                filterVC.filterPodcastsDelegate = self
                filterVC.selectedMin = selectedMinFilter
                filterVC.selectedSec = selectedSecFilter
            }
        }
    }
    
    func updateFilterPodcasts(length: Int16) {
        filterTime = length
        podcastTable.reloadData()
    }
    
    func saveSelected(min: Int, sec: Int) {
        selectedMinFilter = min
        selectedSecFilter = sec
    }
}


// Table Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "podcast_details")
        
        if let detailsView = detailsVC as? podcastDetailsViewController {
            let podcastLength = "\(String(format: "%02d", fetchPodcasts(filterTime)[indexPath.row].length/60)):\(String(format: "%02d", fetchPodcasts(filterTime)[indexPath.row].length%60))"
            detailsView.podcastTitle = fetchPodcasts(filterTime)[indexPath.row].title
            detailsView.podcastDesc = fetchPodcasts(filterTime)[indexPath.row].desc
            detailsView.podcastLength = podcastLength
        }
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}


// Table Data
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchPodcasts(filterTime).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = podcastTable.dequeueReusableCell(withIdentifier: "podcast_cell", for: indexPath) as! podcastTableViewCell
        
        let podcastLength = "\(String(format: "%02d", fetchPodcasts(filterTime)[indexPath.row].length/60)):\(String(format: "%02d", fetchPodcasts(filterTime)[indexPath.row].length%60))"
        
        cell.titleLabel.text = fetchPodcasts(filterTime)[indexPath.row].title
        cell.descLabel.text = fetchPodcasts(filterTime)[indexPath.row].desc
        cell.lengthLabel.text = podcastLength
        
        return cell
    }
}


// Core Data

extension ViewController {

    
    func addPodcast(title: String, desc: String, length: Int16) {
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "Podcast", in: context)
        
        let podcast = Podcast(entity: entityDescription!, insertInto: context)
        
        podcast.title = title
        podcast.desc = desc
        podcast.length = length

        do {
            try context.save()
        } catch {
            
        }
    }
    
    func fetchPodcasts(_ filterLength: Int16?) -> [Podcast] {
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<Podcast> = Podcast.fetchRequest()
        
        request.predicate = NSPredicate(format: "length <= \(filterLength ?? 60*61)")

        
        do {
            let result = try context.fetch(request)
            
            let podcasts = result as [Podcast]
            return podcasts
        } catch {
            print("ERROR: Couldn't fetch podcasts")
        }
        
        return []
    }
    
}
