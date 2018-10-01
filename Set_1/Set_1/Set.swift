//
//  Set.swift
//  Set_1
//
//  Created by Sacha Tobe on 27-09-18.
//  Copyright © 2018 Sacha Tobe. All rights reserved.
//

import Foundation

class Set {
    var cards = [Card]()
    var touchedCards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var setCount = 0
    var scoreCount = 0
    var setFound = false
    
    func chooseCard(at index:Int){
        cards[index].isTouched = !cards[index].isTouched
        if(touchedCards.count > 0){
            for tcIndex in 0..<touchedCards.count {
                if(cards[index].amount == touchedCards[tcIndex].amount && cards[index].color == touchedCards[tcIndex].color && cards[index].shape == touchedCards[tcIndex].shape){
                    touchedCards.remove(at: tcIndex)
                    break
                } else if touchedCards.count < 3 {
                    touchedCards.append(cards[index])
                    break
                }
            }
        } else{
            touchedCards.append(cards[index])
        }
        
        if(touchedCards.count == 3){
            for index in 0..<cards.count{
                cards[index].isTouched = false
            }
            let isSet = checkForSet(cards: touchedCards)
            touchedCards.removeAll()
            if isSet {
                setCount += 1
                setFound = true
            } else{
                cards[index].isTouched = true
                touchedCards.append(cards[index])
            }

        } else{
            setFound = false
        }
    }

    init(numberOfCards: Int) {
        for _ in 0...numberOfCards {
            cards.append(makeRandomCard())
        }
    }
    
    func checkForSet(cards: [Card]) -> Bool{
        var cardsHaveSameColor = false
        var cardsAllDifferentColors = false
        var cardsAllDifferentAmount = false
        var cardsAllSameAmount = false
        var cardsAllDifferentShapes = false
        var cardsAllSameShapes = false
        var isASet = false
        
        let combinedIconMultiplicity = touchedCards.map { $0.amount }
        let combinedIconColors = touchedCards.map { $0.color}
        let combinedIconShapes = touchedCards.map { $0.shape }
        
        if(combinedIconColors[0].hashValue == combinedIconColors[1].hashValue &&
            combinedIconColors[0].hashValue == combinedIconColors[2].hashValue){
            cardsHaveSameColor = true
        }
        
        if(combinedIconColors[0].hashValue != combinedIconColors[1].hashValue &&
            combinedIconColors[0].hashValue != combinedIconColors[2].hashValue &&
            combinedIconColors[1].hashValue != combinedIconColors[2].hashValue){
            cardsAllDifferentColors = true
        }
        
        if(combinedIconMultiplicity[0].hashValue == combinedIconMultiplicity[1].hashValue &&
            combinedIconMultiplicity[0].hashValue == combinedIconMultiplicity[2].hashValue){
            cardsAllSameAmount = true
        }
        
        if(combinedIconMultiplicity[0].hashValue != combinedIconMultiplicity[1].hashValue &&
            combinedIconMultiplicity[0].hashValue != combinedIconMultiplicity[2].hashValue &&
            combinedIconMultiplicity[1].hashValue != combinedIconMultiplicity[2].hashValue){
            cardsAllDifferentAmount = true
        }
        
        if(combinedIconShapes[0].hashValue == combinedIconShapes[1].hashValue &&
            combinedIconShapes[0].hashValue == combinedIconShapes[2].hashValue){
            cardsAllSameShapes = true
        }
        
        if(combinedIconShapes[0].hashValue != combinedIconShapes[1].hashValue &&
            combinedIconShapes[0].hashValue != combinedIconShapes[2].hashValue &&
            combinedIconShapes[1].hashValue != combinedIconShapes[2].hashValue){
            cardsAllDifferentShapes = true
        }
        
        if (cardsAllSameShapes && cardsAllSameAmount) ||
            (cardsAllSameShapes && cardsAllDifferentAmount) ||
            (cardsAllSameAmount && cardsHaveSameColor) ||
            (cardsAllDifferentShapes && cardsAllDifferentColors && cardsAllSameAmount) ||
            (cardsAllDifferentShapes && cardsHaveSameColor && cardsAllDifferentAmount) ||
            (cardsAllDifferentShapes && cardsAllDifferentColors && cardsAllDifferentAmount){
            isASet = true
        }
        return isASet
    }
    
    func makeRandomCard() -> Card{
        var card = Card(color: Color.randomColor(),shape:Shape.randomShape(), amount: Amount.randomAmount(),filling: Filling.randomFilling())
        for existingCard in cards {
            if(existingCard.amount == card.amount && existingCard.color == card.color && existingCard.shape == card.shape){
                card = makeRandomCard()
            }
        }
        return card
    }
}

