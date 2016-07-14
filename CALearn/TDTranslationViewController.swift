//
//  3DTranslationViewController.swift
//  CALearn
//
//  Created by 吴杰健 on 16/7/14.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

import UIKit

class TDTranslationViewController: UIViewController {
    
    @IBOutlet weak var xSlide: UISlider!
    @IBOutlet weak var ySlide: UISlider!
    @IBOutlet weak var zSlide: UISlider!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        _initUI()
    }
    
    private func _initUI() {
        containerView.layer.sublayerTransform.m34 = -1.0 / 500.0
        var transformArr = [CATransform3D]()
        transformArr.append(CATransform3DMakeTranslation(0, 0, 100))
        var transform = CATransform3DMakeTranslation(100, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 0, 1, 0)
        transformArr.append(transform)
        transform = CATransform3DMakeTranslation(0, -100, 0);
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 1, 0, 0);
        transformArr.append(transform)
        transform = CATransform3DMakeTranslation(0, 100, 0);
        transform = CATransform3DRotate(transform, -CGFloat(M_PI_2), 1, 0, 0);
        transformArr.append(transform)
        transform = CATransform3DMakeTranslation(-100, 0, 0);
        transform = CATransform3DRotate(transform, -CGFloat(M_PI_2), 0, 1, 0);
        transformArr.append(transform)
        transform = CATransform3DMakeTranslation(0, 0, -100);
        transform = CATransform3DRotate(transform, CGFloat(M_PI), 0, 1, 0);
        transformArr.append(transform)
        
        for i in 0..<6 {
            let v = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            v.backgroundColor = UIColor.greenColor()
            let label = UILabel()
            label.text = "\(i + 1)"
            label.sizeToFit()
            label.center = CGPoint(x: v.frame.width / 2, y: v.frame.height / 2)
            v.addSubview(label)
            v.layer.transform = transformArr[i]
            v.center = CGPoint(x: containerView.frame.width / 2, y: containerView.frame.height / 2)
            containerView.addSubview(v)
        }
        
        
    }
    
    @IBAction func slideValueChanged(sender: UISlider) {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        
        perspective = CATransform3DRotate(perspective, CGFloat(M_PI) * 2 * CGFloat(xSlide.value), 1, 0, 0)
        perspective = CATransform3DRotate(perspective, CGFloat(M_PI) * 2 * CGFloat(ySlide.value), 0, 1, 0)
        perspective = CATransform3DRotate(perspective, CGFloat(M_PI) * 2 * CGFloat(zSlide.value), 0, 0, 1)

        containerView.layer.sublayerTransform = perspective
    }
    
}
