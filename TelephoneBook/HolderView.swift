//
//  HolderView.swift
//  SBLoader
//
//  Created by Satraj Bambra on 2015-03-17.
//  Copyright (c) 2015 Satraj Bambra. All rights reserved.
//

import UIKit

protocol HolderViewDelegate:class {
  func animateLabel()
}

class HolderView: UIView {

    var parentFrame :CGRect = CGRectZero
    weak var delegate:HolderViewDelegate?
    let ovalLayer = OvalLayer()
    let triangleLayer = TriangleLayer()
    let whiteRectangleLayer = RectangleLayer()
    let arcLayer = ArcLayer()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(red: 20/255, green: 50/255, blue: 60/255, alpha: 1)
    }
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addOval() {
        layer.addSublayer(ovalLayer)
        ovalLayer.expand()
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(HolderView.wobbleOval),
                                               userInfo: nil, repeats: false)
    }
    
    func wobbleOval() {
        layer.addSublayer(triangleLayer)
        ovalLayer.wobble()
        
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self,
                                               selector: #selector(HolderView.drawAnimatedTriangle), userInfo: nil,
                                               repeats: false)
    }
    
    func drawAnimatedTriangle() {
        triangleLayer.animate()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(HolderView.spinAndTransform),
                                               userInfo: nil, repeats: false)
    }
    
    func spinAndTransform() {
        // 1
        layer.anchorPoint = CGPointMake(0.5, 0.6)
        
        // 2
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(M_PI * 2.0)
        rotationAnimation.duration = 0.45
        rotationAnimation.removedOnCompletion = true
        layer.addAnimation(rotationAnimation, forKey: nil)
        
        // 3
        ovalLayer.contract()
        
        NSTimer.scheduledTimerWithTimeInterval(0.45, target: self,
                                               selector: #selector(HolderView.drawWhiteAnimatedRectangle),
                                               userInfo: nil, repeats: false)
    }
    
    func drawWhiteAnimatedRectangle() {
        layer.addSublayer(whiteRectangleLayer)
        whiteRectangleLayer.animateStrokeWithColor(Colors.white)
        NSTimer.scheduledTimerWithTimeInterval(0.40, target: self, selector: #selector(HolderView.drawArc),
                                               userInfo: nil, repeats: false)
    }
    
    func drawArc() {
        layer.addSublayer(arcLayer)
        arcLayer.animate()
        NSTimer.scheduledTimerWithTimeInterval(0.90, target: self, selector: #selector(HolderView.expandView),
                                               userInfo: nil, repeats: false)
    }
    
    func expandView() {
        
        
        backgroundColor = Colors.white
        
        frame = CGRectMake(frame.origin.x - whiteRectangleLayer.lineWidth,
                           frame.origin.y - whiteRectangleLayer.lineWidth,
                           frame.size.width + whiteRectangleLayer.lineWidth * 2,
                           frame.size.height + whiteRectangleLayer.lineWidth * 2)
        
        layer.sublayers = nil
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut,
                                   animations: {
                                    self.frame = self.parentFrame
            }, completion: { finished in
        })
        
    }
    
    func nextPage(){
        
    }
    
}
