//
//  Complex.swift
//  Computer Test
//
//  Created by Piotrek on 19/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import Foundation

public class Complex {
    let re: Float   //Real part
    let im: Float   //Imaginary part
    
    //Init new complex number
    public required init(re: Float, im: Float) {
        self.re = re
        self.im = im
    }
    
    //Init new complex number from Euler's formula
    public convenience init(r: Float, phi: Float) {
        self.init(re: r * cos(phi), im: sin(phi))
    }
    
    //Init new primitive n'th root of unity
    public convenience init(rootOfUnityFor n: Int) {
        if n == 0 {
            self.init(re: 0.0, im: 0.0)
        } else {
            let angle:Float = (2.0 * .pi) / Float(n)
            self.init(r: 1.0, phi: angle)
        }
    }
    
    //Return complex zero
    public class var zero: Complex {
        return self.init(re: 0.0, im: 0.0)
    }
    
    //Return complex one
    public class var one: Complex {
        return self.init(re: 1.0, im: 0.0)
    }
    
    //Return complex imaginary unit
    public class var i: Complex {
        return self.init(re: 0.0, im: 1.0)
    }
    
    public var normalSquare: Float {
        return self.re * self.re + self.im * self.im
    }
    
    //TODO::
    // - Add power
}

extension Complex: Equatable {
    public static func +(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(re: lhs.re + rhs.re, im: lhs.im + rhs.im)
    }
    
    public static func -(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(re: lhs.re - rhs.re, im: lhs.im - rhs.im)
    }
    
    public static func *(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(re: lhs.re * rhs.re - lhs.im * rhs.im,
                        im: lhs.re * rhs.im + rhs.re * lhs.im)
    }
    
    public static func /(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(re: ((lhs.re * rhs.re + lhs.im * rhs.im)/(rhs.re * rhs.re + rhs.im * rhs.im)),
                       im: ((lhs.im * rhs.re - lhs.re * rhs.im)/(rhs.re * rhs.re + rhs.im * rhs.im)))
    }
    
    public static func +=(lhs: inout Complex, rhs: Complex) {
        lhs = lhs + rhs
    }
    
    public static func *=(lhs: inout Complex, rhs: Complex) {
        lhs = lhs * rhs
    }
    
    public static func -=(lhs: inout Complex, rhs: Complex) {
        lhs = lhs - rhs
    }
    
    public static func /=(lhs: inout Complex, rhs: Complex) {
        lhs = lhs / rhs
    }
    
    public static func ==(lhs: Complex, rhs: Complex) -> Bool {
        return (lhs.re == rhs.re) && (lhs.im == rhs.im)
    }
    
    static func !=(lhs: Complex, rhs: Complex) -> Bool {
        return (lhs.re != rhs.re) || (lhs.im != rhs.im)
    }
    
    //Equal approximation
    static func ~=(lhs: Complex, rhs: Complex) -> Bool {
        let t: Float = 0.000000000001
        
        let d1: Float = abs(lhs.re - rhs.re)
        let d2: Float = abs(lhs.im - rhs.im)
        
        return (d1 < t) && (d2 < t)
    }
    
    static prefix func !(hs: Complex) -> Complex {
       return Complex(re: -hs.re, im: -hs.im)
    }
    
    static prefix func -(hs: Complex) -> Complex {
        return Complex.zero - hs
    }
}

extension Complex: CustomStringConvertible {
    public var description: String {
        return "\(self.re) + \(self.im)i"
    }
}
