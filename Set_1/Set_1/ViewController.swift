//
//  ViewController.swift
//  Set_1
//
//  Created by Sacha Tobe on 27-09-18.
//  Copyright © 2018 Sacha Tobe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOfCards: Int {
        get{
            return (cardButtons.count + extraCardsButtons.count)
        }
    }
    
 
    @IBOutlet weak var threeMoreCardsButton: UIButton!
    lazy var game = Set(numberOfCards: numberOfCards)
    @IBOutlet var uiView: UIView!
    @IBOutlet var extraCardsButtons: [UIButton]!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var setCount: UILabel!
    
    override func viewDidLoad() {
        updateViewFromModel()
    }
    
    @IBAction func dealMoreCards(_ sender: UIButton) {
        if extraCardsButtons.count > 2 {
            for _ in 0...2 {
                var button = extraCardsButtons[0]
                let card = game.cards[cardButtons.count + 1]
                button = makeButton(button: button, card: card)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cardButtons.append(button)
                extraCardsButtons.remove(at: 0)
            }
            if extraCardsButtons.count == 0 {
                threeMoreCardsButton.isEnabled = false
                threeMoreCardsButton.backgroundColor = #colorLiteral(red: 1, green: 0.6377320546, blue: 0.6275274771, alpha: 1)
            }
        }
        updateViewFromModel()
    }
    @IBAction func touchNewGame(_ sender: UIButton) {
        game = Set(numberOfCards: numberOfCards)
        setCount.text = "Set count: \(game.setCount)"
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender)  {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        if game.setFound {
            UIView.animate(withDuration: 0.4, animations: {
                self.view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }) { (true) in
                self.view.backgroundColor = #colorLiteral(red: 1, green: 0.7960642895, blue: 0, alpha: 1)
            }
        }
        setCount.text = "Set count: \(game.setCount)"
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            var button = cardButtons[index]
            let card = game.cards[index]
            print(game.cards[index])
            button = makeButton(button: button, card: card)
            if card.isTouched{
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }else{
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }

    func makeButton(button: UIButton, card: Card) -> UIButton{
        switch card.shape {
        case Shape.Oval:
            button.setTitle("●", for: UIControlState.normal)
            break
        case Shape.Rectangle:
            button.setTitle("■", for: UIControlState.normal)
            break
        case Shape.S_Shape:
            button.setTitle("▲", for: UIControlState.normal)
            break
        }
        
        switch card.color {
        case Color.Green:
            button.setTitleColor(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), for: UIControlState.normal)
            break
        case Color.Purple:
            button.setTitleColor(#colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1), for: UIControlState.normal)
            break
        case Color.Red:
            button.setTitleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), for: UIControlState.normal)
            break
        }
        
        switch card.amount {
        case Amount.One:
            break
        case Amount.Two:
            button.setTitle("\(button.title(for: UIControlState.normal) ?? "?") \(button.title(for: UIControlState.normal) ?? "?")", for: UIControlState.normal)
            break
        case Amount.Three:
            button.setTitle("\(button.title(for: UIControlState.normal) ?? "?") \(button.title(for: UIControlState.normal) ?? "?") \(button.title(for: UIControlState.normal) ?? "?")", for: UIControlState.normal)
            break
        }
        return button
    }
    
}

