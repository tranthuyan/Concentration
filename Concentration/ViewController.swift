//
//  ViewController.swift
//  Concentration
//
//  Created by lydia on 5/17/18.
//  Copyright © 2018 lydia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    lazy var game = Concentration(numberOfPairsOfCard: (cardButtons.count + 1) / 2)

    var count : Int = 0 {
        didSet{
            flipsCount.text = "Flips: \(count)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipsCount: UITextField!
    
    @IBAction func resetBtn(_ sender: Any) {
        count = 0

        for index in cardButtons.indices {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
          //  game.cards[index].setTittle
            game.indexOfOneAndOnlyFaceUpCard = nil
            updateViewFromModel()
        }
        
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            count += 1
            updateViewFromModel()
        } else {
            print("NIL")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.5647058824, blue: 0.3176470588, alpha: 0) : #colorLiteral(red: 0, green: 0.5647058824, blue: 0.3176470588, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🧟‍♂️","👼","🐙","🐹","🐯","🌹","🍀","🌵","🦐","🎃","☠️","💩"]
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform (UInt32 (emojiChoices.count - 1)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

