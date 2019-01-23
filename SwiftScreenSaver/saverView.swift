//
//  saverView.swift
//

//  Created by Eric Li on 1/23/19.
//  Copyright © 2019 O-R-G inc. All rights reserved.
//
//  http://blog.viacom.tech/2016/06/27/making-a-macos-screen-saver-in-swift-with-scenekit/
//

import ScreenSaver

class saverView: ScreenSaverView {
    
    
    override init?(frame: NSRect, isPreview: Bool) {
        
        super.init(frame: frame, isPreview: isPreview)
        self.animationTimeInterval = 1.0 / 30.0
        
        
    }
    
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        
        let context = NSGraphicsContext.current!.cgContext
        context.saveGState()
        context.setFillColor(NSColor.red.cgColor)
        context.fillEllipse(in: rect)
        context.restoreGState()
    
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
