//
//  Register.swift
//  Computer Test
//
//  Created by Piotrek on 19/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import Darwin
import Foundation

public protocol Register {
    var stable: Bool { get }
    var quantum: QuantumRegister? { get }
    var classical: ClassicalRegister? { get }
}

public extension Register {
    public var stable: Bool {
        if self is QuantumRegister {
            return false
        } else {
            return true
        }
    }
    
    public var quantum: QuantumRegister? {
        return self as? QuantumRegister
    }
    
    public var classical: ClassicalRegister? {
        return self as? ClassicalRegister
    }
}

public class QuantumRegister: Register {
    public var ket: Ket
    public var width: Int
    
    public var isCollapsed: Bool
    
    public required init(width: Int, initial: ClassicalRegister) {
        self.width = width
        self.ket = Ket(from: initial)
        
        self.isCollapsed = false
    }
    
    public func insert(classical: ClassicalRegister) {
        self.ket.insert(classical: classical)
    }
    
    public func apply(gate: Gate) {
        self.ket.apply(gate: gate)
    }
    
    public func collapse() -> ClassicalRegister {
        self.isCollapsed = true
        
        let sample = Float.random(in: 0...1)
        var cumulative: Float = 0.0
        
        for (state, element) in self.ket.elements.enumerated() {
            cumulative += element.normalSquare
            
            if sample < cumulative {
                return ClassicalRegister(fromState: state, width: self.width)
            }
        }
        
        return ClassicalRegister(fromState: 0, width: self.width)
    }

    public func probability() -> [Float] {
        var p: [Float] = []
        let smallElements = self.ket.elements.prefix(through: Ket.init(size: self.width).size)
        
        for element in smallElements {
            p.append(element.normalSquare)
        }
        
        return p
    }
}

public class ClassicalRegister: Register {
    public var bits: [Int]
    public var lastOperation: Operator.Action?
    
    public required init(bits: [Int]) {
        for bit in bits {
            assert(bit == 0 || bit == 1)
        }
        self.bits = bits
    }
    
    public convenience init(fromState: Int, width: Int) {
        var bits: [Int] = []
        var remainingState = fromState
        
        for i in 0..<width {
            let pos = (width - i - 1)
            let value = Int(pow(Double(2),Double(pos)))
            
            if value <= remainingState {
                remainingState -= value
                bits.insert(1, at: 0)
            } else {
                bits.insert(0, at: 0)
            }
        }
        
        self.init(bits: bits)
    }
    
    public convenience init(fromInt: Int, width: Int) {
        self.init(fromState: fromInt, width: width)
    }
    
    public convenience init(zero width: Int) {
        let bits = Array<Int>(repeating: 0, count: width)
        
        self.init(bits: bits)
    }
    
    public func apply(operation: Operator) {
        var value = self.toInt
        self.lastOperation = operation.type
        
        switch operation.type {
        case .addition:
            value += operation.value
        case .substraction:
            value -= operation.value
        case .multiplication:
            value *= operation.value
        case .division:
            value /= operation.value
        }
        
        var bits: [Int] = []
        var remainingState = value
        
        for i in 0..<width {
            let pos = (width - i - 1)
            let value = Int(pow(Double(2),Double(pos)))
            
            if value <= remainingState {
                remainingState -= value
                bits.insert(1, at: 0)
            } else {
                bits.insert(0, at: 0)
            }
        }
        
        self.bits = bits
    }
    
    public var width: Int {
        return self.bits.count
    }
    
    public var toInt: Int {
        return self.state
    }
    
    public var state: Int {
        var state: Int = 0
        
        for(pos, bit) in self.bits.enumerated() {
            if bit != 0 {
                state += Int(pow(Double(2),Double(pos)))
                
            }
        }
        
        return state
    }
}
