//
//  Gates.swift
//  Computer Test
//
//  Created by Piotrek on 19/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import Foundation

extension Gate {
    public class func identity(width: Int) -> Gate {
        let m = Matrix.init(identity: width)
        
        return Gate(width: width, matrix: m)
    }
    
    public class func hadamard(n: Int) -> Gate {
        let sqrt2inv = Float(1.0)/Float(2.0).squareRoot()
        let m: Matrix
        
        switch n {
        case 0:
            m = Matrix(identity: 1)
        case 1:
            m = Matrix(real: [sqrt2inv,  sqrt2inv, sqrt2inv, -sqrt2inv])
        case 2:
            m = Matrix(real: [0.5, 0.5, 0.5, 0.5, 0.5, -0.5,  0.5, -0.5, 0.5, 0.5, -0.5, -0.5, 0.5, -0.5, -0.5,  0.5])
        default:
            m = Matrix.init(size: 0)
            print("Cannot compute Hadamard gate bigger than 2!")
        }
        
        return Gate(width: n, matrix: m)
    }
    
    public class func pauliX() -> Gate {
        let m = Matrix(real: [0.0, 1.0, 1.0, 0.0])
        return Gate(width: 1, matrix: m)
    }
    
    public class func pauliY() -> Gate {
        let m = Matrix(size: 2, elements: [Complex.zero, -Complex.i, Complex.i, Complex.zero])
        return Gate(width: 1, matrix: m)
    }
    
    public class func pauliZ() -> Gate {
        let m = Matrix(real: [1.0, 0.0, 0.0, -1.0])
        return Gate(width: 1, matrix: m)
    }
    
    public class func phaseShift(phi: Float) -> Gate {
        let m = Matrix(size: 2, elements: [Complex.one, Complex.zero, Complex.zero, Complex(r: 1.0, phi: phi)])
        return Gate(width: 1, matrix: m)
    }
    
    public class func swap() -> Gate {
        let m = Matrix(real: [1.0, 0.0, 0.0, 0.0,
                              0.0, 0.0, 1.0, 0.0,
                              0.0, 1.0, 0.0, 0.0,
                              0.0, 0.0, 0.0, 1.0])
        return Gate(width: 2, matrix: m)
    }
    
    public class func sqrtSwap() -> Gate {
        let alpha1 = Complex(re: 0.5, im: 0.5)
        let alpha2 = Complex(re: 0.5, im: -0.5)
        
        let m = Matrix(size: 2, elements: [Complex.one, Complex.zero, Complex.zero, Complex.zero,
                                           Complex.zero, alpha1, alpha2, Complex.zero,
                                           Complex.zero, alpha2, alpha1, Complex.zero,
                                           Complex.zero, Complex.zero, Complex.zero, Complex.one])
        return Gate(width: 2, matrix: m)
    }
    
    public class func controlledNot() -> Gate {
        let m = Matrix(real: [1.0, 0.0, 0.0, 0.0,
                              0.0, 1.0, 0.0, 0.0,
                              0.0, 0.0, 0.0, 1.0,
                              0.0, 0.0, 1.0, 0.0])
        return Gate(width: 2, matrix: m)
    }
    
    public class func controlled(by: Matrix) -> Gate {
        let m = Matrix(real: [1.0, 0.0, 0.0, 0.0,
                              0.0, 1.0, 0.0, 0.0,
                              0.0, 0.0, 0.0, 0.0,
                              0.0, 0.0, 0.0, 0.0])
        m.embed(with: by, i: 2, j: 2)
        
        return Gate(width: 2, matrix: m)
    }
    
    public class func controlledX() -> Gate {
        return Gate.controlled(by: Gate.pauliX().matrix)
    }
    
    public class func controlledY() -> Gate {
        return Gate.controlled(by: Gate.pauliY().matrix)
    }
    
    public class func controlledZ() -> Gate {
        return Gate.controlled(by: Gate.pauliZ().matrix)
    }
    
    public class func toffoli() -> Gate {
        let m = Matrix.init(identity: 8)
        let exchange = Matrix(real: [0.0, 1.0, 1.0, 0.0])
        
        m.embed(with: exchange, i: 5, j: 5)
        
        return Gate(width: 3, matrix: m)
    }
    
    public class func deutschGate(fn: [Int]) -> Gate {
        let m = Matrix.init(identity: 4)
        let exchange = Matrix.init(real: [0.0, 1.0, 1.0, 0.0])
        
        if fn[0] == 1 {
            m.embed(with: exchange, i: 0, j: 0)
        } else if fn[1] == 1 {
            m.embed(with: exchange, i: 2, j: 2)
        }
        
        return Gate(width: 2, matrix: m)
    }

}
