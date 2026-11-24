//
//  ComputerNode.swift
//  Computer Test
//
//  Created by Piotrek on 23/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import SceneKit

public class QuantumRegisterNode: SCNNode {
    
    
    private let registerBaseSize: CGFloat = 0.5
    private var qubits: [ComplexNode] = []
    
    public let registerBaseNode = SCNNode()
    
    public init(register: QuantumRegister) {
        super.init()
        
        let baseSize = self.registerBaseSize * CGFloat(register.ket.size)
        self.registerBaseNode.geometry = SCNPlane(width: baseSize, height: baseSize)
        self.registerBaseNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        self.registerBaseNode.position = SCNVector3(0.0, 0.0, 0.0)
        
        for i in 0..<register.ket.size {
            for j in 0..<register.ket.size {
                let complexNode = ComplexNode()
                complexNode.position = SCNVector3(CGFloat(i)*registerBaseSize, 0.0, CGFloat(j)*registerBaseSize)
                
                if j%2 == 0 {
                    if i%2 == 0 {
                        complexNode.geometry?.firstMaterial?.diffuse.contents = UIColor.lightGray
                    } else {
                        complexNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
                    }
                } else {
                    if i%2 == 0 {
                        complexNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
                    } else {
                        complexNode.geometry?.firstMaterial?.diffuse.contents = UIColor.lightGray
                    }
                }
                
                
                self.addChildNode(complexNode)
                self.qubits.append(complexNode)
            }
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    public func updateRegister(_ ket: Ket, itteration: Int, isLast: Bool) {
        for (i, qubit) in self.qubits.enumerated() {
            if itteration == 0 {
                qubit.animateComplexChange(complex: ket.elements[i], isInitial: true, isLast: isLast)
            } else {
                qubit.animateComplexChange(complex: ket.elements[i], isLast: isLast)
            }
        }
    }
}

