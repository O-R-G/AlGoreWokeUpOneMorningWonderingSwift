//
//  saverView.swift
//

//  Created by Eric Li on 1/23/19.
//  Copyright © 2019 O-R-G inc. All rights reserved.
//
//  http://blog.viacom.tech/2016/06/27/making-a-macos-screen-saver-in-swift-with-scenekit/
//

import ScreenSaver
import SceneKit
import MetalKit
import Foundation

class saverView: ScreenSaverView {
    
    var scnView: SCNView!
    var scale: CGFloat = 1.0
    var detail = 240
    
    func prepareSceneKitView() {
        
        // create a new scene
        let scene = SCNScene()
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 8.75)
        
        let earthSphere = SCNSphere(radius: 1.0*scale)
        earthSphere.segmentCount = detail
        let earthImg = Bundle(for: saverView.self).path(forResource: "earth_lights_lrg", ofType: "jpg")!
        earthSphere.firstMaterial?.diffuse.contents = NSImage(byReferencingFile: earthImg)
        earthSphere.levelsOfDetail = []
        
        let earthNode = SCNNode(geometry: earthSphere)
        earthNode.position = SCNVector3(x: 0, y: 0, z: 0)
        earthNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2*CGFloat.pi, z: 0, duration: 360)))
        scene.rootNode.addChildNode(earthNode)
        
        // retrieve the SCNView
        let scnView = self.scnView
        
        // set the scene to the view
        scnView?.scene = scene
        
        // show statistics such as fps and timing information
        scnView?.showsStatistics = false

    }
    
    override init?(frame: NSRect, isPreview: Bool) {
        
        super.init(frame: frame, isPreview: isPreview)
        
        //probably not needed, but cant hurt to check in case we re-use this code later
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        self.scnView = SCNView.init(frame: self.bounds)
        
        //prepare it with a scene
        self.prepareSceneKitView()
        
        //set scnView background color
        scnView.backgroundColor = NSColor.black
        
        //add it in as a subview
        self.addSubview(self.scnView)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
