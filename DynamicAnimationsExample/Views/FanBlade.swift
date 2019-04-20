//
//  FanBlade.swift
//  DynamicAnimationsExample
//
//  Created by farhad jebelli on 4/19/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class FanBlade: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func draw(_ rect: CGRect) {
        let contex = UIGraphicsGetCurrentContext()!
        contex.translateBy(x: rect.width/2, y: rect.height/2)
        
        drawCircle(contex: contex, color: UIColor.yellow, radius: 90)
        
        contex.saveGState()
        drawBigBelade(contex: contex, rect: rect)

        contex.saveGState()
        contex.rotate(by: 2 * .pi / 3)
        drawBigBelade(contex: contex, rect: rect)

        contex.saveGState()
        contex.rotate(by: 2 * .pi / 3)
        drawBigBelade(contex: contex, rect: rect)
        drawSmallBelade(contex: contex, rect: rect)

        contex.restoreGState()
        drawSmallBelade(contex: contex, rect: rect)
        contex.restoreGState()
        drawSmallBelade(contex: contex, rect: rect)

        drawCircle(contex: contex, color: UIColor.black, radius: 15)
        
    }
    
    func drawCircle(contex: CGContext, color: UIColor, radius: CGFloat) {
        
        contex.setFillColor(color.cgColor)
        contex.addArc(center: .zero, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)
        contex.fillPath()
    }
    
    func drawBigBelade(contex: CGContext, rect: CGRect) {
        drawBelade(contex: contex, rect: rect, radius: 80, color: UIColor.black)
    }
    
    
    func drawSmallBelade(contex: CGContext, rect: CGRect) {
        drawBelade(contex: contex, rect: rect, radius: 20, color: UIColor.magenta)
    }
    
    func drawBelade(contex: CGContext, rect: CGRect, radius: CGFloat, color: UIColor) {
        let first = CGPoint(x: 0, y: radius).applying(CGAffineTransform(rotationAngle: -.pi / 6))
        //let second = first.applying(CGAffineTransform(rotationAngle: .pi / 3))
        let bezier = UIBezierPath()
        bezier.move(to: .zero)
        bezier.addLine(to: first)
        bezier.addArc(withCenter: .zero, radius: radius, startAngle: -.pi * 2 / 3, endAngle: -.pi / 3, clockwise: true)
        bezier.addLine(to: .zero)
        
        color.setFill()
        bezier.fill()
        
    }
    
    
}
