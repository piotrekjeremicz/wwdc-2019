//
//  QubitNode.swift
//  Computer Test
//
//  Created by Piotrek on 21/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import SceneKit

public class QubitNode: SCNNode {
    override public init() {
        super.init()
        
        let sphere = SCNSphere(radius: 1)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.black
        material.reflective.contents = UIColor(red: 0, green: 0.764, blue: 1, alpha: 1)
        material.reflective.intensity = 3
        material.transparent.contents = UIColor.black.withAlphaComponent(0.3)
        material.transparencyMode = .default
        material.fresnelExponent = 4
        
        sphere.materials = [material]
        
        self.geometry = sphere

        let xLine = SCNNode.lineNode(from: SCNVector3(0, 0, 0), to: SCNVector3(1, 0, 0))
        self.addChildNode(xLine)
        
        let yLine = SCNNode.lineNode(from: SCNVector3(0, 0, 0), to: SCNVector3(0, 1, 0))
        self.addChildNode(yLine)
        
        let zLine = SCNNode.lineNode(from: SCNVector3(0, 0, 0), to: SCNVector3(0, 0, 1))
        self.addChildNode(zLine)
        
        let qubitPosition = SCNNode.lineNode(from: SCNVector3(-0.5, 0, 0), to: SCNVector3(0.5, 0.0, 0.0), radius: 0.03, color: .red )
        self.addChildNode(qubitPosition)
        qubitPosition.pivot = SCNMatrix4MakeTranslation(0.0, 0.5, 0.0)
        
        let minusText = self.createText(at: SCNVector3(-1.4, -0.25, 0), text: "|-⟩")
        self.addChildNode(minusText)
        
        let plusText = self.createText(at: SCNVector3(1.1, -0.25, 0), text: "|+⟩")
        self.addChildNode(plusText)
        
        let zeroText = self.createText(at: SCNVector3(-0.15, 1.0, 0), text: "|0⟩")
        self.addChildNode(zeroText)
        
        let oneText = self.createText(at: SCNVector3(-0.15, -1.5, 0), text: "|1⟩")
        self.addChildNode(oneText)
        
        let qubitChangePosition = SCNAction.rotate(by: .pi/2, around: SCNVector3(0.0, 0.0, -1.0), duration: 0.5)
        qubitChangePosition.timingMode = .easeInEaseOut
        
        let delay80 = SCNAction.wait(duration: 8.0)
        let delay40 = SCNAction.wait(duration: 4.0)
        let delay15 = SCNAction.wait(duration: 1.5)
        let repeatAction = SCNAction.repeatForever(SCNAction.sequence([
                qubitChangePosition,
                delay15,
                qubitChangePosition,
                delay15,
                qubitChangePosition,
                delay15,
                qubitChangePosition,
                delay15
            ])
        )
        
        let sequence = SCNAction.sequence([
                delay40,
                repeatAction
            ])
        
        qubitPosition.runAction(sequence)
        let qbitAction = SCNAction.rotate(by: 360.0 * .pi / 180.0, around: SCNVector3(0.0, 1.0, 0.0), duration: 120.0)
        
        self.runAction(SCNAction.repeatForever(SCNAction.sequence([delay80, qbitAction])))
        self.runAction(SCNAction.sequence([delay80,SCNAction.rotate(by:30.0 * .pi / 180.0, around: SCNVector3(1.0, 0.0, 0.0), duration: 10.0)]))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createText(at position: SCNVector3, text: String) -> SCNNode {
        let text = SCNText(string: text, extrusionDepth: 0.1)
        text.font = UIFont.systemFont(ofSize: 1.0)
        text.flatness = 0.01
        text.firstMaterial?.diffuse.contents = UIColor.white
        
        let fontSize = Float(0.2)
        
        let textNode = SCNNode(geometry: text)
        textNode.scale = SCNVector3(fontSize, fontSize, fontSize)
        textNode.position = position
        
        return textNode
    }
}
