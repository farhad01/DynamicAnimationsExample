//
//  GravityViewController.swift
//  DynamicAnimationsExample
//
//  Created by farhad jebelli on 4/19/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class GravityViewController: UIViewController {
    @IBOutlet var seg: UIStoryboardSegue!
    @IBOutlet var ball: UIButton!
    var animation: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var push: UIPushBehavior!
    var item: UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animation = UIDynamicAnimator(referenceView: view)
        
        collision = UICollisionBehavior(items: [ball])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        animation.addBehavior(collision)
        
        gravity = UIGravityBehavior(items: [ball])
        animation.addBehavior(gravity)
        
        item = UIDynamicItemBehavior(items: [ball])
        item.elasticity = 0.4
        animation.addBehavior(item)
        
        
                // Do any additional setup after loading the view.
    }
    

    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translate = sender.translation(in: view)
        if sender.state == .ended {
            if push != nil {
                animation.removeBehavior(push)
            }
            push = UIPushBehavior(items: [ball], mode: .instantaneous)
            push.pushDirection = CGVector(dx: translate.x/5, dy: translate.y/5)
            animation.addBehavior(push)
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
