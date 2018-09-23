//
//  Concentration.swift
//  Concentration
//
//  Created by Sacha Tobe on 18-09-18.
//  Copyright © 2018 Sacha Tobe. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    var scoreCount = 0
    
    func chooseCard(at index:Int){
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // Check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoreCount += 2
                }
                else{
                    checkIfCardHasBeenSeen(index: index)
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else{
                //Either no cards or 2 cards are face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                checkIfCardHasBeenSeen(index: index)
                indexOfOneAndOnlyFaceUpCard = index
            }
            cards[index].hasBeenSeen = true
        }
    }
    
    func checkIfCardHasBeenSeen(index: Int){
        if cards[index].hasBeenSeen, scoreCount > 0{
            scoreCount -= 1
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        var toShuffle = [Card]()
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            toShuffle += [card,card]
        }
        for _ in 1...toShuffle.count {
            let rand = Int(arc4random_uniform(UInt32(toShuffle.count)))
            cards.append(toShuffle[rand])
            toShuffle.remove(at: rand)
        }
    }
}
