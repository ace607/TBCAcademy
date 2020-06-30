//
//  ViewController.swift
//  Lecture49
//
//  Created by Nika Kirkitadze on 6/25/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let transition = Animator()
    @IBOutlet weak var tableView: UITableView!
    
    var tappedIndex = 0
    
    var tappedCell: StoryCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate  = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_story" {
            if let storyVC = segue.destination as? StoryViewController {
                storyVC.transitioningDelegate = self
                storyVC.selectedIndex = tappedIndex
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as! HeaderCell
            
            cell.didSelectItemAction = { [weak self] indexPath, storyCell in
                self?.tappedIndex = indexPath.row
                
                self?.tappedCell = storyCell
                
                self?.performSegue(withIdentifier: "show_story", sender: self)
                
                
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NormalCell.identifier, for: indexPath) as! NormalCell
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 622
        }
        
        return 150
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedCell = tappedCell,
        let selectedSuperView = selectedCell.superview
        else { return nil}
        
        transition.originFrame = selectedSuperView.convert(selectedCell.frame, to: nil)
        transition.originFrame = CGRect(
          x: transition.originFrame.origin.x,
          y: transition.originFrame.origin.y,
          width: transition.originFrame.size.width,
          height: transition.originFrame.size.height
        )
        
        transition.presenting = true
        
        return transition
    }
    

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      transition.presenting = false
        
      return transition
    }
}
