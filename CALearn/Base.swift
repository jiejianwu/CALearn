//
//  Base.swift
//  CALearn
//
//  Created by 吴杰健 on 16/7/17.
//  Copyright © 2016年 吴杰健. All rights reserved.
//


import GLKit

extension GLKMatrix3 {
    
    init(transform3D: CATransform3D) {
        self.init(m: (Float(transform3D.m11), Float(transform3D.m12), Float(transform3D.m13), Float(transform3D.m21), Float(transform3D.m22), Float(transform3D.m23), Float(transform3D.m31), Float(transform3D.m32), Float(transform3D.m33)))
    }
    
}