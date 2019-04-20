//
//  PopupIndicatorView.swift
//  DynamicAnimationsExample
//
//  Created by farhad jebelli on 4/20/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class PopupIndicatorView: UIView {

    var right: CALayer!
    var left: CALayer!
    
    let lineWidth: CGFloat = 6
    
    var isStraight: Bool = true {
        didSet {
            if oldValue == isStraight {
                return
            }
            let rightAnimation = createAnimation(isRight: true, isStraight: isStraight)
            let leftAnimation = createAnimation(isRight: false, isStraight: isStraight)
            
            //right.add(rightAnimation, forKey: "right")
            //left.add(leftAnimation, forKey: "left")
            
            right.transform = rightAnimation.toValue as! CATransform3D
            left.transform = leftAnimation.toValue as! CATransform3D
            
            
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
        right = CALayer()
        left = CALayer()
        
        right.backgroundColor = UIColor.lightGray.cgColor
        left.backgroundColor = UIColor.lightGray.cgColor
        
        right.cornerRadius = lineWidth / 2
        left.cornerRadius = lineWidth / 2
        
        layer.addSublayer(right)
        layer.addSublayer(left)
        
    }
    override func layoutSublayers(of layer: CALayer) {
        let y = (layer.bounds.height - lineWidth) / 2
        let width = layer.bounds.width * 0.6
        let x = layer.bounds.width - width
        right.frame = CGRect(x: x, y: y, width: width, height: lineWidth)
        left.frame = CGRect(x: 0, y: y, width: width, height: lineWidth)
    }
    
    func createAnimation(isRight: Bool, isStraight: Bool) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
        animation.fromValue = isRight ? right.presentation()?.transform : left.presentation()?.transform
        let toValue = isRight ? CATransform3DMakeRotation(.pi / 6, 0.0001, 0.0001, -1.0) : CATransform3DMakeRotation(.pi / 6, 0.0001, 0.0001, 1.0)
        animation.toValue = isStraight ? CATransform3DIdentity : toValue
        animation.duration = 0.3
        animation.isRemovedOnCompletion = true
        return animation
        
    }
    
}
