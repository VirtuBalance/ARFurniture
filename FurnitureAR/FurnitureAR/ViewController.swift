//
//  ViewController.swift
//  FurnitureAR
//
//  Created by Raghav Tirumale on 4/11/20.
//  Copyright © 2020 Raghav Tirumale. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
    }
    
    @IBAction func addCube(_ sender: Any) {
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))

        let cc = getCameraCoordinates(sceneView: sceneView)
        cubeNode.position = SCNVector3(cc.x, cc.y, cc.z)
        
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    @IBAction func addCup(_ sender: Any) {
        let cupNode = SCNNode()
        let cc = getCameraCoordinates(sceneView: sceneView)
        cupNode.position = SCNVector3(cc.x, cc.y, cc.z)
        
        guard let virtualObjectScene = SCNScene(named: "chair.scn", inDirectory: "Models.scnassets/cup")
            else {
                return
        }
        
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        cupNode.addChildNode(wrapperNode)
        
        sceneView.scene.rootNode.addChildNode(cupNode)
        
    }
    
    struct myCameraCoordinates {
        var x = Float()
        var y = Float()
        var z = Float()
    }
    
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        
        return cc
    }


}

