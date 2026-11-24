//
//  Ket.swift
//  Computer Test
//
//  Created by Piotrek on 19/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import Foundation

public class Ket {
    public let size: Int
    public var elements: [Complex]
    
    //Init standard ket
    required public init(size: Int) {
        self.size = size
        self.elements = Array<Complex>(repeating: Complex.zero, count: maxSize)
    }
    
    //Init ket from classical register
    public convenience init(from classical: ClassicalRegister) {
        self.init(size: classical.bits.count)
        self.elements[classical.state] = Complex.one
    }
    
    //Check if ket is valid
    public var isValid: Bool {
        var sum: Float = 0.0
        
        for element in self.elements {
            sum += element.normalSquare
        }
        
        return abs(1.0 - sum) < 0.00000000001
    }
    
    //Check if ket represent classical state
    public var isClassical: Bool {
        var z = 0
        var o = 0
        var a = 0
        
        for element in self.elements {
            if element == Complex.zero {
                z += 1
            } else if element == Complex.one {
                o += 1
            } else {
                a += 1
            }
        }
        
        return o == 1 && 0 == a
    }
    
    public func size(register width: Int) -> Int {
        return Int(pow(Double(2),Double(width)))
    }
    
    public func insert(classical: ClassicalRegister) {
        self.elements[classical.state] = Complex.one
    }
    
    public func apply(gate: Gate) {
        self.elements = gate.matrix * self.elements
    }
    
    func copy(with zone: NSZone? = nil) -> Ket {
        let copy = Ket(size: self.size)
        copy.elements = self.elements
        return copy
    }
}
