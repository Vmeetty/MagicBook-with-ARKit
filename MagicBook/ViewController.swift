//
//  ViewController.swift
//  MagicBook
//
//  Created by user on 02.05.2022.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
        
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "For Book", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }


    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let videoNode = SKVideoNode(fileNamed: "pawpatrol.mp4")
            videoNode.play()
            let videoScene = SKScene(size: CGSize(width: 480, height: 360))
            videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
            videoNode.yScale = -1.0
            videoScene.addChild(videoNode)
            
            
            let imagePlane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            imagePlane.firstMaterial?.diffuse.contents = videoScene
            let planeNode = SCNNode(geometry: imagePlane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
        }
        
        return node
    }
}
