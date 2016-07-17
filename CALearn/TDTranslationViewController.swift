//
//  3DTranslationViewController.swift
//  CALearn
//
//  Created by 吴杰健 on 16/7/14.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

import UIKit
import GLKit

class SurfaceView: UIView {
    
    var shadowLayer: CALayer = CALayer()
    
    func suitShadowLayer() {
        layer.addSublayer(shadowLayer)
        shadowLayer.frame = layer.bounds
    }
    
}

class TDTranslationViewController: UIViewController {
    
    @IBOutlet weak var xSlide: UISlider!
    @IBOutlet weak var ySlide: UISlider!
    @IBOutlet weak var zSlide: UISlider!
    @IBOutlet weak var containerView: UIView!
    
    let borderLength: CGFloat = 200
    let LIGHT_DIRECTION = GLKVector3(v: (1, 1, 1))
    
    var lightDirection: GLKVector3 {
        return GLKVector3Add(LIGHT_DIRECTION, GLKVector3(v: (xSlide.value, ySlide.value, zSlide.value)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        _initUI()
    }
    
    private func _initUI() {
        containerView.layer.sublayerTransform.m34 = -1.0 / 500.0
        let gap = borderLength / 2
        var transformArr = [CATransform3D]()
        transformArr.append(CATransform3DMakeTranslation(0, 0, gap))
        var transform = CATransform3DMakeTranslation(gap, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 0, 1, 0)
        transformArr.append(transform)
        transform = CATransform3DMakeTranslation(0, -gap, 0);
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 1, 0, 0);
        transformArr.append(transform)
        transform = CATransform3DMakeTranslation(0, gap, 0);
        transform = CATransform3DRotate(transform, -CGFloat(M_PI_2), 1, 0, 0);
        transformArr.append(transform)
        transform = CATransform3DMakeTranslation(-gap, 0, 0);
        transform = CATransform3DRotate(transform, -CGFloat(M_PI_2), 0, 1, 0);
        transformArr.append(transform)
        transform = CATransform3DMakeTranslation(0, 0, -gap);
        transform = CATransform3DRotate(transform, CGFloat(M_PI), 0, 1, 0);
        transformArr.append(transform)
        
        for i in 0..<6 {
            let v = SurfaceView(frame: CGRect(x: 0, y: 0, width: borderLength, height: borderLength))
            v.suitShadowLayer()
            v.layer.borderWidth = 0.5
            v.layer.borderColor = UIColor.grayColor().CGColor
            v.backgroundColor = UIColor.whiteColor()
            let label = UILabel()
            label.text = "\(i + 1)"
            label.sizeToFit()
            label.center = CGPoint(x: v.frame.width / 2, y: v.frame.height / 2)
            v.addSubview(label)
            v.layer.transform = transformArr[i]
            v.center = CGPoint(x: containerView.frame.width / 2, y: containerView.frame.height / 2)
            containerView.addSubview(v)
        }
        
        changeLight()
    }
    
    func changeLight() {
        for v in containerView.subviews {
            guard let v = v as? SurfaceView else {
                continue
            }
            let transform = view.layer.transform
            let matrix3 = GLKMatrix3(transform3D: transform)

            var normal = GLKVector3Make(0, 0, 1)
            normal = GLKMatrix3MultiplyVector3(matrix3, normal)
            normal = GLKVector3Normalize(normal)

            let light = GLKVector3Normalize(lightDirection)
            let dotProduct = GLKVector3DotProduct(light, normal)

            let shadow = (1 + dotProduct) / 2
            
            v.shadowLayer.backgroundColor = UIColor(white: 0, alpha: CGFloat(shadow)).CGColor
        }
    }
    
    @IBAction func slideValueChanged(sender: UISlider) {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        
        perspective = CATransform3DRotate(perspective, CGFloat(M_PI) * 2 * CGFloat(xSlide.value), 1, 0, 0)
        perspective = CATransform3DRotate(perspective, CGFloat(M_PI) * 2 * CGFloat(ySlide.value), 0, 1, 0)
        perspective = CATransform3DRotate(perspective, CGFloat(M_PI) * 2 * CGFloat(zSlide.value), 0, 0, 1)

        containerView.layer.sublayerTransform = perspective
        
        changeLight()
    }
    
}
