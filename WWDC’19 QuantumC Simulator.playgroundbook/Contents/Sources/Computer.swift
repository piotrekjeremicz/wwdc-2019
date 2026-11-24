//
//  Computer.swift
//  Computer Test
//
//  Created by Piotrek on 19/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import Foundation

public class Computer {
    public enum State {
        case undefined      //Undefined state
        case run            //Superposition state
        case stable         //Decompressed state - clasical value
    }
    
    public var state: State
    public let width: Int!
    public var register: Register
    
    public var value: Int? {
        if let classicalRegister = self.register as? ClassicalRegister {
            return classicalRegister.toInt
        } else {
            return nil
        }
    }
    
    public required init(qubits: Int) {
        self.state = .undefined
        self.width = qubits
        self.register = QuantumRegister(width: qubits, initial: ClassicalRegister.init(zero: qubits))
    }
    
    public convenience init(bits n: Int) {
        self.init(qubits: n)
        
        let emptyBits = Array<Int>(repeating: 0, count: n)
        self.register = ClassicalRegister(bits: emptyBits)
        
        self.state = .stable
    }

    public func initialize(value: Int) {
        if self.state == .stable {
            self.register = ClassicalRegister(fromInt: value, width: self.width)
        } else {
            let classical = ClassicalRegister(fromInt: value, width: self.width)
            self.register = QuantumRegister(width: self.width, initial: classical)
            
            self.state = .run
        }
        
    }
    
    public func initialize(values: [Int]) {
        guard let first = values.first else {
            self.initialize(value: 0)
            return
        }
        
        let classical = ClassicalRegister(fromInt: first, width: self.width)
        self.register = QuantumRegister(width: self.width, initial: classical)
        
        if self.state != .stable {
            for i in 1..<values.count {
                let classical = ClassicalRegister(fromInt: values[i], width: self.width)
                self.register.quantum?.insert(classical: classical)
            }
            
            self.state = .run
        }
    }
    
    public func apply(gate: Gate) {
        if let quantumRegister = self.register as? QuantumRegister {
            quantumRegister.apply(gate: gate)
        }
    }
    
    public func apply(operation: Operator) {
        if let classicalRegister = self.register as? ClassicalRegister {
            classicalRegister.apply(operation: operation)
        }
    }
    
    public func collapse() {
        if let quantumRegister = self.register as? QuantumRegister {
            self.register = quantumRegister.collapse()
            
            self.state = .stable
        }
    }
    
    public func reset() {
        self.state = .undefined
    }
    
    public func probability() -> [Float]? {
        if let quantumRegister = self.register as? QuantumRegister {
            return quantumRegister.probability()
        } else {
            return nil
        }
    }
}
