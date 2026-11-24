//
//  Operator.swift
//  Computer Test
//
//  Created by Piotrek on 20/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import Foundation

public class Operator {
    
    public enum Action {
        case addition
        case substraction
        case multiplication
        case division
    }
    
    public let type: Action
    public let value: Int
    
    required init(value: Int, type: Action) {
        self.type = type
        self.value = value
    }
    
    public class func addition(value: Int) -> Operator {
        return self.init(value: value, type: .addition)
    }
    
    public class func substraction(value: Int) -> Operator {
        return self.init(value: value, type: .substraction)
    }
    
    public class func multiplication(value: Int) -> Operator {
        return self.init(value: value, type: .multiplication)
    }
    
    public class func division(value: Int) -> Operator {
        return self.init(value: value, type: .division)
    }
}
