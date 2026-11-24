//
//  QubitViewController.swift
//  Computer Test
//
//  Created by Piotrek on 21/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import UIKit
import SceneKit

public class QubitViewController: UIViewController {

    private var scene = SCNScene()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupScene()
        
        let sceneView = SCNView(frame: self.view.frame)
        self.view = sceneView

        sceneView.scene = self.scene
        sceneView.backgroundColor = UIColor(red: 23.0/255.0, green: 24.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        sceneView.autoenablesDefaultLighting = true
    }
    
    private func setupScene() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0.0, 0.0, 5.0)
        self.scene.rootNode.addChildNode(cameraNode)
        
        let light = SCNLight()
        light.type = .omni
        light.intensity = 1000.0
        light.color = UIColor.white
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(0.0, 0.0, 5.0)
        
        self.scene.rootNode.addChildNode(lightNode)
        
        let qubitNode = QubitNode()
        self.scene.rootNode.addChildNode(qubitNode)
        
        let complexNode = BoxNode()
        self.scene.rootNode.addChildNode(complexNode)
    }
}
