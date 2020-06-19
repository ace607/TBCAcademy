//
//  DetailsViewController.swift
//  hw41
//
//  Created by Admin on 6/16/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var coffeeName: UILabel!
    @IBOutlet weak var coffeeImg: UIImageView!
    @IBOutlet weak var coffeeNameLAbel: UILabel!
    @IBOutlet weak var coffeePriceLabel: UILabel!
    
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var coffeeCountLabel: UILabel!
    
    @IBOutlet weak var sBtn: UIButton!
    @IBOutlet weak var mBtn: UIButton!
    @IBOutlet weak var lBtn: UIButton!
    
    @IBOutlet weak var sugar0: UIButton!
    @IBOutlet weak var sugar1: UIButton!
    @IBOutlet weak var sugar2: UIButton!
    @IBOutlet weak var sugar3: UIButton!
    
    @IBOutlet weak var addBtn: UIButton!
    
    var currentCoffee: Coffee?
    
    let cd = CDManager()
    
    var sugar = 0
    
    var size = "Small"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        topView.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        topView.layer.cornerRadius = 40
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        topView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        topView.layer.shadowOffset = CGSize(width: 0, height: 50)
        topView.layer.shadowRadius = 80
        topView.layer.shadowOpacity = 1
        
        coffeeName.text = currentCoffee?.name
        
        // დიდი ფოტოები არ იყო xd-ში და ცუდი ხარისხით ჩანდა ამიტომ ყველას ერთი გავუკეთე
//        currentCoffee?.image.downloadImage(completion: { (img) in
//            DispatchQueue.main.async {
//                self.coffeeImg.image = img
//            }
//        })
        
        addBtn.layer.cornerRadius = 55/2
        
        coffeeNameLAbel.text = currentCoffee?.name
        coffeePriceLabel.text = currentCoffee?.priceText
        
        minusBtn.layer.cornerRadius = 14
        minusBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        plusBtn.layer.cornerRadius = 14
        plusBtn.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        sBtn.alpha = 1
        mBtn.alpha = 0.5
        lBtn.alpha = 0.5
        sugar0.alpha = 1
        sugar1.alpha = 0.5
        sugar2.alpha = 0.5
        sugar3.alpha = 0.5

        
    }
    
    @IBAction func onBack(_ sender: UIButton) {
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAdd(_ sender: UIButton) {
        cd.addOrder(coffee: currentCoffee!, count: Int(coffeeCountLabel.text!)!, sugar: sugar, size: size)
        NotificationCenter.default.post(name: NSNotification.Name("update_orders"), object: nil)
    }
    
    @IBAction func onPlus(_ sender: UIButton) {
        coffeeCountLabel.text = String(Int(coffeeCountLabel.text!)! + 1)
    }
    
    @IBAction func onMinus(_ sender: UIButton) {
        if Int(coffeeCountLabel.text!) != 1 {
            coffeeCountLabel.text = String(Int(coffeeCountLabel.text!)! - 1)
        }
    }
    
    @IBAction func onS(_ sender: UIButton) {
        size = "Small"
        sBtn.alpha = 1
        mBtn.alpha = 0.5
        lBtn.alpha = 0.5
    }
    @IBAction func onM(_ sender: UIButton) {
        size = "Medium"
        sBtn.alpha = 0.5
        mBtn.alpha = 1
        lBtn.alpha = 0.5

    }
    
    @IBAction func onL(_ sender: UIButton) {
        size = "Large"
        sBtn.alpha = 0.5
        mBtn.alpha = 0.5
        lBtn.alpha = 1
    }
    
    @IBAction func sugarZero(_ sender: UIButton) {
        sugar = 0
        sugar0.alpha = 1
        sugar1.alpha = 0.5
        sugar2.alpha = 0.5
        sugar3.alpha = 0.5
    }
    
    @IBAction func sugarOne(_ sender: UIButton) {
        sugar = 1
        sugar0.alpha = 0.5
        sugar1.alpha = 1
        sugar2.alpha = 0.5
        sugar3.alpha = 0.5
    }
    @IBAction func sugarTwo(_ sender: UIButton) {
        sugar = 2
        sugar0.alpha = 0.5
        sugar1.alpha = 0.5
        sugar2.alpha = 1
        sugar3.alpha = 0.5
    }
    @IBAction func sugarThree(_ sender: UIButton) {
        sugar = 3
        sugar0.alpha = 0.5
        sugar1.alpha = 0.5
        sugar2.alpha = 0.5
        sugar3.alpha = 1
    }
}
