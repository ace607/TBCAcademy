//
//  ViewController.swift
//  hw47-vc-transitions
//
//  Created by Admin on 6/24/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let transition = Animator()
    
    @IBOutlet weak var vcCollection: UICollectionView!
    
    var trees = [Tree]()
    
    var selectedTree: Tree?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        transition.dismissCompletion = { [weak self] in
            guard let selectedIndexes = self?.vcCollection.indexPathsForSelectedItems,
                let selectedCell = self?.vcCollection.cellForItem(at: selectedIndexes[0]) as? controllerCollectionViewCell
          else { return }
          selectedCell.isHidden = false
        }
            
        trees.append(contentsOf: [
            Tree(name: "AAAAA", description: "Proin imperdiet neque id arcu malesuada, non vestibulum velit iaculis. Nam elit tortor, sollicitudin eu sollicitudin ullamcorper, malesuada eget mi. Nunc sed sodales risus. Suspendisse bibendum, libero at elementum pulvinar, nulla turpis dapibus lectus, ac ultricies enim eros eget ligula. Etiam gravida dapibus elit ut maximus. ", image: UIImage(named: "vc-1")!),
            Tree(name: "BBBBB", description: "libero at elementum pulvinar, nulla turpis dapibus lectus, ac ultricies enim eros eget ligula. Etiam gravida dapibus elit ut maximus.sollicitudin eu sollicitudin ullamcorper, malesuada eget mi. Nunc sed sodales risus. Suspendisse bibendum ", image: UIImage(named: "vc-2")!),
            Tree(name: "CCCCCCC", description: "eu sollicitudin ullamcorper, malesuada eget mi. Nunc sed sodales risus. Suspendisse bibendum, libero at elementum pulvinar, nulla turpis dapibus lectus, ac ultricies enim eros eget ligula. Etiam gravida dapibus elit ut maximus. ", image: UIImage(named: "vc-3")!),
            Tree(name: "DDDDDD", description: "Proin imperdiet neque id arcu malesuada, non vestibulum velit iaculis. Nam elit tortor, sollicitudin eu sollicitudin ullamcorper. ", image: UIImage(named: "vc-4")!)
        ])
        
        vcCollection.delegate = self
        vcCollection.dataSource = self
        vcCollection.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_details" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.transitioningDelegate = self
                detailsVC.tree = selectedTree
            }
        }
    }

}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTree = trees[indexPath.row]
        performSegue(withIdentifier: "show_details", sender: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trees.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = vcCollection.dequeueReusableCell(withReuseIdentifier: "vc_cell", for: indexPath) as! controllerCollectionViewCell
        
        cell.layer.cornerRadius = 15
        cell.treeImg.image = trees[indexPath.row].image
        
        return cell
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 250
        let width = height * (view.frame.size.width / view.frame.size.height)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexes = vcCollection.indexPathsForSelectedItems,
            let selectedCell = vcCollection.cellForItem(at: selectedIndexes[0]) as? controllerCollectionViewCell,
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
        
        selectedCell.isHidden = true
        
        return transition
    }
    

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      transition.presenting = false
        
      return transition
    }
}
