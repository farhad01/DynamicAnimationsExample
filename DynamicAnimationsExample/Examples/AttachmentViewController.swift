//
//   AttachmentViewController.swift
//  DynamicAnimationsExample
//
//  Created by farhad jebelli on 4/20/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class AttachmentViewController: UIViewController {

    @IBOutlet var first: UIImageView!
    @IBOutlet var orbs: [UIImageView]!
    

    var animation: UIDynamicAnimator!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animation = UIDynamicAnimator(referenceView: view)
        
        orbs.forEach({ orb in
            let center = view.convert(orb.center, from: orb.superview)
            let attachment = UIAttachmentBehavior(item: orb, attachedToAnchor: center + CGPoint(x: 0, y: -100))
            attachment.length = 100
            animation.addBehavior(attachment)
            
        })
        
        let item = UIDynamicItemBehavior(items: orbs)
        item.resistance = 0
        item.elasticity = 1
        item.allowsRotation = false
        animation.addBehavior(item)
        
        let collision = UICollisionBehavior(items: orbs)
        animation.addBehavior(collision)
        
        let gravity = UIGravityBehavior(items: orbs)
        gravity.magnitude = 1.0
        animation.addBehavior(gravity)
        
        let push = UIPushBehavior(items: [first], mode: .instantaneous)
        push.angle = .pi
        push.magnitude = 1
        animation.addBehavior(push)
    }
    
    @IBAction func pause(_ sender: Any) {
        animation.removeAllBehaviors()
    }
}
