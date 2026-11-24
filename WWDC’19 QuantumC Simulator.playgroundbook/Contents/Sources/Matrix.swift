//
//  Matrix.swift
//  Computer Test
//
//  Created by Piotrek on 19/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import Foundation

let maxSize: Int = 32
let maxElements: Int = maxSize * maxSize

public class Matrix {
    let size: Int
    var elements: [Complex]
    
    //Init new zero filled matrix
    required init(size: Int) {
        
        self.size = (size <= maxSize) ? size : maxSize
        self.elements = Array<Complex>(repeating: Complex.zero, count: maxElements)
    }
    
    //Init new matrix from given elements
    convenience init(size: Int, elements: [Complex]) {
        self.init(size: size)
        
        for (index, element) in elements.enumerated() {
            self.set(i: index/size, j: index%size, value: element)
        }
    }
    
    //Init new identity matrix
    convenience init(identity size: Int) {
        self.init(size: size)
        
        for i in 0..<self.size {
            self.elements[i * maxSize + i] = Complex.one
        }
    }
    
    //Init new real matrix
    convenience init(real values: [Float]) {
        var size = 0
        var elements: [Complex] = []
        
        for i in 1...maxSize {
            if i*i <= values.count {
                size = i
            } else {
                break
            }
        }
        
        for (index, value) in values.enumerated() {
            elements.append(Complex(re: value, im: 0.0))
        }
        
        self.init(size: size, elements: elements)
    }
    
    //Get specific value
    public func get(i: Int, j: Int) -> Complex {
        return self.elements[i * maxSize + j]
    }
    
    //Set specific value
    public func set(i: Int, j: Int, value: Complex) {
        self.elements[i * maxSize + j] = value
    }
    
    //Embed another matrix into current one
    public func embed(with other: Matrix, i: Int, j: Int) {
        for x in 0..<other.size {
            for y in 0..<other.size {
                let value = other.get(i: x, j: y)
                self.set(i: i + x, j: i + y, value: value)
            }
        }
    }
    
    //Validate permutation
    public func isPermuted(permutation: [Int]) -> Bool {
        let sorted = permutation.sorted()
        
        for (i, val) in sorted.enumerated() {
            if i != val {
                return false
            }
        }
        
        return true
    }
    
    //Permute rows to new matrix
    public func permuteRows(permutation: [Int]) -> Matrix {
        let m = Matrix(size: self.size)
        
        for (si, ti) in permutation.enumerated() {
            for j in 0..<self.size {
                m.set(i: ti, j: j, value: self.get(i: si, j: j))
            }
        }
        
        return m
    }
    
    //Permute columns to new matrix
    public func permutateColumns(permutation: [Int]) -> Matrix {
        let m = Matrix(size: self.size)
        
        for (sj, tj) in permutation.enumerated() {
            for i in 0..<self.size {
                m.set(i: i, j: tj, value: self.get(i: i, j: sj))
            }
        }
        
        return m
    }
    
    //TODO:
    // - Partial equal
}

extension Matrix {
    static func +(lhs: inout Matrix, rhs: Matrix) -> Matrix {
        let m = Matrix(size: lhs.size)
        
        for i in 0..<lhs.size {
            for j in 0..<lhs.size {
                m.set(i: i, j: j, value: lhs.get(i: i, j: j) + rhs.get(i: i, j: j))
            }
        }
        
        return m
    }
    
    static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
        let m = Matrix(size: lhs.size)
        
        for i in 0..<lhs.size {
            for j in 0..<lhs.size {
                var val = Complex.zero
                
                for k in 0..<lhs.size {
                    val += lhs.get(i: i, j: k) * rhs.get(i: k, j: j)
                }
                
                m.set(i: i, j: j, value: val)
            }
        }
        
        return m
    }
    
    static func *(lhs: Matrix, rhs: [Complex]) -> [Complex] {
        var output = Array<Complex>(repeating: Complex.zero, count: maxSize)
                
        for i in 0..<lhs.size {
            var val = Complex.zero
            
            for k in 0..<lhs.size {
                val += lhs.get(i: i, j: k) * rhs[k]
            }
            
            output[i] = val
        }
        
        return output
    }
    
    static func ==(lhs: Matrix, rhs: Matrix) -> Bool {
        for i in 0..<maxSize {
            if lhs.elements[i] != rhs.elements[i] {
                return false
            }
        }
        
        return true
    }
    
    //Equal approximation
    static func ~=(lhs: Matrix, rhs: Matrix) -> Bool {
        if lhs.size != rhs.size { return false }
        
        for i in 0..<lhs.size {
            for j in 0..<lhs.size {
                if !lhs.get(i: i, j: j) ~= rhs.get(i: i, j: j) { return false }
            }
        }
        
        return true
    }
}

extension Matrix: CustomStringConvertible {
    public var description: String {
        var description = "["
        
        
        for i in 0..<self.size {
            for j in 0..<self.size {
                description += "\(self.get(i: i, j: j)), "
            }
            
            description = String(description.dropLast(2))
            description += "\n "
        }
        
        description = String(description.dropLast(2))
        description += "]"
        
        return description
    }
}
