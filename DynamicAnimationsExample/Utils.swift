//
//  Utils.swift
//  DynamicAnimationsExample
//
//  Created by farhad jebelli on 4/19/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import CoreGraphics
extension CGRect {
    var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2) + origin
    }
    
}

func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: rhs.x + lhs.x, y: rhs.y + lhs.y)
}
