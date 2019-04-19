//
//  GravityViewController.swift
//  DynamicAnimationsExample
//
//  Created by farhad jebelli on 4/19/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class GravityViewController: UIViewController {
    @IBOutlet var ball: UIButton!
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var push: UIPushBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [ball])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [ball])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func ballTapped(_ sender: Any) {
        if push != nil {
            animator.removeBehavior(push)
        }
        push = UIPushBehavior(items: [ball], mode: .instantaneous)
        push.angle = (2...4).map({CGFloat($0 * 30) * .pi / 180}).randomElement() ?? CGFloat.pi / 2
        push.magnitude = 90
        
        animator.addBehavior(push)
        
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
