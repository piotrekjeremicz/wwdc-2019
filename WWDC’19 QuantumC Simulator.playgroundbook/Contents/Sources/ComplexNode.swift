//
//  ComplexNode.swift
//  Computer Test
//
//  Created by Piotrek on 23/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import SceneKit


public class ComplexNode: SCNNode {
    
    private let complexSize: CGFloat = 0.5
    private let complexMinHeight: CGFloat = 0.01
    private let complexMaxHeight: CGFloat = 0.5
    
    private var run: Bool
    private let box: SCNBox
    private var complex: Complex
    
    public override init() {
        self.box = SCNBox(width: complexSize, height: complexMinHeight, length: complexSize, chamferRadius: 0.0)
        self.complex = Complex.zero
        self.run = false
        super.init()
        
        self.geometry = self.box
        self.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        self.geometry?.firstMaterial?.lightingModel = .blinn
        self.geometry?.firstMaterial?.reflective.intensity = 3
        self.geometry?.firstMaterial?.ambient.intensity = 3
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    public func animateComplexChange(complex: Complex, isInitial: Bool = false, isLast: Bool = false) {
        if self.complex != complex || !isInitial {
            self.complex = complex
            
            let newHeight = CGFloat(abs(self.complex.re)) * complexMaxHeight
            var newColor = UIColor.white
            var yTransform: CGFloat = 0.0
            
            if self.box.height > newHeight {
                yTransform = -(newHeight/2)
            } else {
                yTransform = newHeight/2
            }
            
            if !isInitial || !isLast {
                if self.complex.re >= 0 {
                    if self.complex.im >= 0 {
                        newColor = UIColor(red: CGFloat(abs(self.complex.im)), green: 1.0 - CGFloat(abs(self.complex.im)), blue: 0.0, alpha: 1.0)
                    } else {
                        newColor = UIColor(red: 1.0 - CGFloat(abs(self.complex.im)), green: CGFloat(abs(self.complex.im)), blue: 0.0, alpha: 1.0)
                    }
                } else {
                    if self.complex.im >= 0 {
                        newColor = UIColor(red: 1.0 - CGFloat(abs(self.complex.im)), green:  CGFloat(abs(self.complex.im)), blue: 0.0, alpha: 1.0)
                    } else {
                        newColor = UIColor(red: CGFloat(abs(self.complex.im)), green: 1.0 - CGFloat(abs(self.complex.im)), blue: 0.0, alpha: 1.0)
                    }
                }
            }
            
            if isLast {
                newColor = .white
            }
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            self.box.height = newHeight
            self.geometry?.firstMaterial?.diffuse.contents = newColor
            self.position = SCNVector3(self.position.x, Float(yTransform), self.position.z)
            SCNTransaction.commit()
        }
        
    }
}

