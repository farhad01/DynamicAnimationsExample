//
//  BorderButton.swift
//  DynamicAnimationsExample
//
//  Created by farhad jebelli on 4/19/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import Foundation
import UIKit
class BorderButton: UIButton {
    
    var isOn: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    private func setupView() {
        
    }
    
    override func draw(_ rect: CGRect) {
        let contex = UIGraphicsGetCurrentContext()

        let bezier = UIBezierPath(roundedRect: rect, cornerRadius: rect.width / 2)
        let innerRect = rect.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        bezier.append(UIBezierPath(roundedRect: innerRect, cornerRadius: innerRect.width / 2))
        bezier.usesEvenOddFillRule = true

        bezier.addClip()

        let color: UIColor
        
        if isOn {
            color = UIColor.blue
        } else {
            color = UIColor.gray
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: [color.cgColor, UIColor.white.cgColor] as CFArray, locations: [0.0, 0.2])
        
        contex?.drawRadialGradient(gradient!, startCenter: rect.center, startRadius: rect.width / 2, endCenter: rect.center, endRadius: 0, options: [])
        
        
        
        
    }
}

