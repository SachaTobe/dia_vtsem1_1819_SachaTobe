//
//  File.swift
//  Set_1
//
//  Created by Sacha Tobe on 27-09-18.
//  Copyright © 2018 Sacha Tobe. All rights reserved.
//

import Foundation

struct Card {
    
    var isTouched = false
    var color: Color
    var shape: Shape
    var amount: Amount
    var filling: Filling
    
    init(color: Color, shape: Shape, amount:Amount, filling:Filling){
        self.amount = amount
        self.color = color
        self.shape = shape
        self.filling = filling
    }
}

enum Color: UInt32{
    case Red
    case Green
    case Purple
    
    private static let _count: Color.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = Color(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomColor() -> Color {
        // pick and return a new value
        let rand = arc4random_uniform(_count)
        return Color(rawValue: rand)!
    }
}

enum Shape : UInt32{
    case Oval
    case Rectangle
    case S_Shape
    
    private static let _count: Shape.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = Shape(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomShape() -> Shape {
        // pick and return a new value
        let rand = arc4random_uniform(_count)
        return Shape(rawValue: rand)!
    }
}

enum Amount: UInt32{
    case One
    case Two
    case Three
    
    private static let _count: Amount.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = Amount(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomAmount() -> Amount {
        // pick and return a new value
        let rand = arc4random_uniform(_count)
        return Amount(rawValue: rand)!
    }
}

enum Filling: UInt32{
    case Full
    case Empty
    case Stripes
    
    private static let _count: Filling.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = Filling(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomFilling() -> Filling {
        // pick and return a new value
        let rand = arc4random_uniform(_count)
        return Filling(rawValue: rand)!
    }
}




