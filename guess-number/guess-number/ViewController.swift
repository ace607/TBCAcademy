//
//  ViewController.swift
//  guess-number
//
//  Created by Admin on 5/22/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet weak var currentNum: UILabel!
    
    @IBOutlet weak var numberSlider: UISlider!
    
    @IBOutlet weak var resultText: UILabel!
    
    var guessNum = Int.random(in: 1...100)
    
    var resultTxt: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currentNum.text = String(guessNum)
    }

    @IBAction func onGuess(_ sender: UIButton) {
        if guessNum >= (Int(numberSlider.value) - 10) && guessNum <= (Int(numberSlider.value) + 10) {
            resultTxt = "იდიალური შედეგია"
        } else if guessNum >= (Int(numberSlider.value) - 20) && guessNum <= (Int(numberSlider.value) + 20) {
            resultTxt = "საკმაოდ კარგია"
        } else {
            resultTxt = "ახლოსაც კი არაა"
        }
        resultText.text = resultTxt
        
        addResult(resultText: resultTxt!, num: "\(Int(numberSlider.value))/\(guessNum)")
        
        guessNum = Int.random(in: 1...100)
        
        currentNum.text = String(guessNum)
        
        
    }
    
    @IBAction func onHistory(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let historyVC   = storyboard.instantiateViewController(withIdentifier: "history_vc")
        
        self.navigationController?.pushViewController(historyVC, animated: true)

    }
    
}

extension ViewController {
    func addResult(resultText: String, num: String) {
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "Result", in: context)
        
        let result = Result(entity: entityDescription!, insertInto: context)
        
        result.text = resultText
        result.resultNum = num
        result.date = Date()

        do {
            try context.save()
        } catch {
            
        }
    }
}
