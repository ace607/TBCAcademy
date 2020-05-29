//
//  ViewController.swift
//  animations-one
//
//  Created by Admin on 5/27/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var cardsTable: UITableView!
    
    @IBOutlet weak var plusBtn: UIImageView!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    
    @IBOutlet weak var selectLabel: UILabel!
    
    @IBOutlet weak var selectView: UIView!
    
    
    var viewHeight: NSLayoutConstraint!
    
    var isViewHidden = true
    
    let allCards = [
        ("Ace of Spades", "https://i.dlpng.com/static/png/6829482_preview.png"),
        ("Ace of Heart", "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/English_pattern_ace_of_hearts.svg/512px-English_pattern_ace_of_hearts.svg.png"),
        ("Ace of Diamonds", "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/839f488c-d377-4eeb-999f-6bcace090bb4/d3kggj0-45c7a07f-e731-42ed-9416-db2bab3c0efb.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3sicGF0aCI6IlwvZlwvODM5ZjQ4OGMtZDM3Ny00ZWViLTk5OWYtNmJjYWNlMDkwYmI0XC9kM2tnZ2owLTQ1YzdhMDdmLWU3MzEtNDJlZC05NDE2LWRiMmJhYjNjMGVmYi5wbmcifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ.ZGfQX6LdjxMoMc2aXlvmmcZD69J2gniK4WkcYtk9L_c"),
        ("Ace of Clubs", "https://i.dlpng.com/static/png/1131916_preview_preview.png"),
        ("Joker", "https://pngimage.net/wp-content/uploads/2018/06/joker-card-png.png"),
        ("King of Hearts", "https://playingcardcollector.files.wordpress.com/2015/02/king-of-hearts-by-ralph-sevelius.jpg?w=584"),
        ("King of Spades", "https://i7.pngguru.com/preview/458/229/186/king-of-spades-playing-card-suit-jack-queen.jpg")
    ]
    
    var cardList = [
        ("Ace of Spades", "https://i.dlpng.com/static/png/6829482_preview.png"),
        ("Ace of Heart", "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/English_pattern_ace_of_hearts.svg/512px-English_pattern_ace_of_hearts.svg.png"),
        ("Ace of Diamonds", "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/839f488c-d377-4eeb-999f-6bcace090bb4/d3kggj0-45c7a07f-e731-42ed-9416-db2bab3c0efb.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3sicGF0aCI6IlwvZlwvODM5ZjQ4OGMtZDM3Ny00ZWViLTk5OWYtNmJjYWNlMDkwYmI0XC9kM2tnZ2owLTQ1YzdhMDdmLWU3MzEtNDJlZC05NDE2LWRiMmJhYjNjMGVmYi5wbmcifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ.ZGfQX6LdjxMoMc2aXlvmmcZD69J2gniK4WkcYtk9L_c"),
        ("Ace of Clubs", "https://i.dlpng.com/static/png/1131916_preview_preview.png")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardsTable.delegate = self
        cardsTable.dataSource = self
        
        selectView.isUserInteractionEnabled = true
        plusBtn.isUserInteractionEnabled = true
        
        print(selectView.frame.origin.y)
        
        plusBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleSelectView)))
        
        let url1 = URL(string: allCards[0].1)
        let url2 = URL(string: allCards[1].1)
        let url3 = URL(string: allCards[2].1)
        let url4 = URL(string: allCards[3].1)
        let url5 = URL(string: allCards[4].1)
        let url6 = URL(string: allCards[5].1)
        let url7 = URL(string: allCards[6].1)
        
        img1.kf.setImage(with: url1)
        img2.kf.setImage(with: url2)
        img3.kf.setImage(with: url3)
        img4.kf.setImage(with: url4)
        img5.kf.setImage(with: url5)
        img6.kf.setImage(with: url6)
        img7.kf.setImage(with: url7)
        
        img1.isUserInteractionEnabled = true
        img2.isUserInteractionEnabled = true
        img3.isUserInteractionEnabled = true
        img4.isUserInteractionEnabled = true
        img5.isUserInteractionEnabled = true
        img6.isUserInteractionEnabled = true
        img7.isUserInteractionEnabled = true
        
        img1.tag = 0
        img2.tag = 1
        img3.tag = 2
        img4.tag = 3
        img5.tag = 4
        img6.tag = 5
        img7.tag = 6
        
        img1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addRow)))
        img2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addRow)))
        img3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addRow)))
        img4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addRow)))
        img5.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addRow)))
        img6.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addRow)))
        img7.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addRow)))
        
    }

    
    @objc func toggleSelectView() {
        print(#function)
        if isViewHidden {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.15, options: [], animations: {
                self.cardsTable.frame.origin.y = self.view.safeAreaLayoutGuide.layoutFrame.minY + 150
                print(self.selectView.frame.origin.y)
                print(self.selectView.frame.size.height)
                self.plusBtn.transform = CGAffineTransform(rotationAngle: .pi/4)
                self.selectLabel.frame.origin.y += 100
                self.selectLabel.frame.origin.x -= 50
                
            }) { (f) in
                self.isViewHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.15, options: [], animations: {
                self.cardsTable.frame.origin.y = self.view.safeAreaLayoutGuide.layoutFrame.minY + 60
                print(self.selectView.frame.origin.y)
                print(self.selectView.frame.size.height)
                self.plusBtn.transform = CGAffineTransform(rotationAngle: -(.pi/2))
                self.selectLabel.frame.origin.y -= 100
                self.selectLabel.frame.origin.x += 50
                
            }) { (f) in
                self.isViewHidden = true
            }
        }
    }
    
    @objc func addRow(gesture: UITapGestureRecognizer) {

        switch gesture.view?.tag {
        case 0:
            cardList.append(allCards[0])
        case 1:
            cardList.append(allCards[1])
        case 2:
            cardList.append(allCards[2])
        case 3:
            cardList.append(allCards[3])
        case 4:
            cardList.append(allCards[4])
        case 5:
            cardList.append(allCards[5])
        case 6:
            cardList.append(allCards[6])
        default:
            print("")
        }
        cardsTable.reloadData()
        toggleSelectView()
    }
    
    
    
    
    func showCard(image: String) {
    
        let cardImage = UIImageView(frame: CGRect(x: (view.frame.width / 2) - 100, y: view.frame.height, width: 200, height: 200))
        let url = URL(string: image)
        cardImage.kf.setImage(with: url)
        
        cardImage.contentMode = .scaleAspectFit
        cardImage.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        
        self.view.addSubview(cardImage)
        
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.15, options: [], animations: {
            cardImage.frame.origin.y -= 330
            cardImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (f) in
            
            
            UIView.animate(withDuration: 0.5, animations: {
                cardImage.frame.origin.y -= 0
            }) { (f) in
                UIView.transition(with: cardImage, duration: 0.7, options: .transitionFlipFromBottom,
                                  animations: {
                    
                }, completion: nil)

                UIView.animate(withDuration: 0.35, delay: 0, options: [], animations: {
                    cardImage.alpha = 0
                }) { (f) in
                cardImage.removeFromSuperview()
                }
            }
            
            
            
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showCard(image: cardList[indexPath.row].1)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardsTable.dequeueReusableCell(withIdentifier: "card_cell", for: indexPath) as! CardTableViewCell
        
        cell.cardName.text = cardList[indexPath.row].0
        
        let url = URL(string: cardList[indexPath.row].1)
        cell.cardImage.kf.setImage(with: url)
        
        return cell
    }
    
    
}
