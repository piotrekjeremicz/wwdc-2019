//
//  QubitNode.swift
//  Computer Test
//
//  Created by Piotrek on 21/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import SceneKit

public class BoxNode: SCNNode {
    override public init() {
        super.init()

        let box = SCNBox(width: 0.25, height: 0.25, length: 0.25, chamferRadius: 0.0)
        
        self.geometry = box
        self.position = SCNVector3(0.0, -0.6, 3.0)
        self.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        self.geometry?.firstMaterial?.lightingModel = .blinn
        self.geometry?.firstMaterial?.reflective.intensity = 3
        self.geometry?.firstMaterial?.ambient.intensity = 3
        
        self.pivot = SCNMatrix4MakeTranslation(0.0, 0.125, 0.0)
        
        self.setupAnimation()
    }
    
    private func setupAnimation() {
        let delay20 = SCNAction.wait(duration: 2.0)
        let delay40 = SCNAction.wait(duration: 4.0)
        
        let zeroState = SCNAction.run { (_) in
            self.animateComplex(height: 0.01, pivot: 0.25, color: .red)
        }
        let plusState = SCNAction.run { (_) in
            self.animateComplex(height: 0.01, pivot: 0.25, color: .green)
        }
        let oneState = SCNAction.run { (_) in
            self.animateComplex(height: 0.25, pivot: 0.125, color: .green)
        }
        let minusState = SCNAction.run { (_) in
            self.animateComplex(height: 0.25, pivot: 0.125, color: .red)
        }
        
        let repeatAction = SCNAction.repeatForever(SCNAction.sequence([
            zeroState,
            delay20,
            plusState,
            delay20,
            oneState,
            delay20,
            minusState,
            delay20
            ])
        )
        
        let sequence = SCNAction.sequence([
            delay40,
            repeatAction
            ])
        
        self.runAction(sequence)
    }
    
    private func animateComplex(height: CGFloat, pivot: Float, color: UIColor) {
        let box = (self.geometry as! SCNBox)
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        box.height = height
        self.pivot = SCNMatrix4MakeTranslation(0.0, pivot, 0.0)
        self.geometry?.firstMaterial?.diffuse.contents = color
        SCNTransaction.commit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
