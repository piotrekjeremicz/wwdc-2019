//
//  QuantumComputerViewController.swift
//  Computer Test
//
//  Created by Piotrek on 23/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import UIKit
import SceneKit

public class QuantumComputerViewController: UIViewController {

    private var scene = SCNScene()
    private var qRegisterNode: QuantumRegisterNode?
    private var ketChanges: [Ket] = []
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupScene()
        
        let sceneView = SCNView(frame: self.view.frame)
        self.view = sceneView
        
        sceneView.scene = self.scene
        sceneView.backgroundColor = UIColor(red: 23.0/255.0, green: 24.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
    }
    
    private func setupScene() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(2.0, 4.0, 7.0)
        self.scene.rootNode.addChildNode(cameraNode)
        
        let light = SCNLight()
        light.type = .omni
        light.intensity = 1000.0
        light.color = UIColor.white
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(0.0, 2.0, 0.0)
        
        //
        let quantumComputer = Computer(qubits: 4)
        quantumComputer.initialize(value: 5)
        guard let qRegister = quantumComputer.register as? QuantumRegister else { return }
        //
        
        self.qRegisterNode = QuantumRegisterNode(register: qRegister)
        self.scene.rootNode.addChildNode(qRegisterNode!)
        
        let constraint = SCNLookAtConstraint(target: self.qRegisterNode!.registerBaseNode)
        constraint.isGimbalLockEnabled = true
        cameraNode.constraints = [constraint]
        
    }
    
    public func updateRegister(_ ket: Ket, itteration: Int = 1, isLast: Bool = false) {
        self.qRegisterNode!.updateRegister(ket, itteration: itteration, isLast: isLast)
    }
    
    public func registerKetChange(_ register: Register) {
        if let qRegister = register as? QuantumRegister {
            self.ketChanges.append(qRegister.ket.copy())
        } else if let cRegister = register as? ClassicalRegister {
            self.ketChanges.append(QuantumRegister(width: cRegister.width, initial: cRegister).ket)
        }
        
    }
    
    public func run(completion: @escaping () -> Void) {
        for (i, ket) in self.ketChanges.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500 + i*1000)) {
                if i + 1 == self.ketChanges.count {
                    self.updateRegister(ket, itteration: i, isLast: true)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                        completion()
                    }
                } else {
                    self.updateRegister(ket, itteration: i)
                }
            }
        }
    }
}
