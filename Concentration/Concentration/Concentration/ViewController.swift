//
//  ViewController.swift
//  Concentration
//
//  Created by Sacha Tobe on 18-09-18.
//  Copyright © 2018 Sacha Tobe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count/2)
    var emojiChoices = [["👌🏼","👊🏼","👋🏼","👍🏼","🤙🏼","🤞🏼","💪🏼","👎🏼","🙌🏼","🖖🏼"],
                        ["❤️","💚","💙","🖤","💜","💕","💓","💘","💝","💔"],
                        ["🐶","🐱","🐹","🐭","🐷","🐯","🦁","🐼","🐨","🐸"],
                        ["0️⃣","1️⃣","2️⃣","3️⃣","4️⃣","5️⃣","6️⃣","7️⃣","8️⃣","9️⃣"],
                        ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐"],
                        ["🍆","🍐","🍑","🍋","🍌","🍉","🍇","🍓","🍈","🍒"]]
    lazy var currentEmojiChoices = emojiChoices[Int(arc4random_uniform(UInt32(emojiChoices.count)))]
    var emoji = [Int:String]()
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        flipCountLabel.text = "Flipcount: 0"
        scoreCountLabel.text = "Score: 0"
        game = Concentration(numberOfPairsOfCards: cardButtons.count/2)
        updateViewFromModel()
        currentEmojiChoices = emojiChoices[Int(arc4random_uniform(UInt32(emojiChoices.count)))]
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender)  {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        flipCountLabel.text = "Flipcount: \(game.flipCount)"
        scoreCountLabel.text = "Score: \(game.scoreCount)"
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, currentEmojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(currentEmojiChoices.count)))
            emoji[card.identifier] = currentEmojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

