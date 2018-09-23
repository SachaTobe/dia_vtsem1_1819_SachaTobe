//
//  Card.swift
//  Concentration
//
//  Created by Sacha Tobe on 18-09-18.
//  Copyright © 2018 Sacha Tobe. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var hasBeenSeen = false
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init (){
        self.identifier = Card.getUniqueIdentifier()
    }
}
