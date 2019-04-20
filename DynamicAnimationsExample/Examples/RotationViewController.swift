//
//  RotationViewController.swift
//  DynamicAnimationsExample
//
//  Created by farhad jebelli on 4/19/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {
    @IBOutlet var fanBlade: FanBlade!
    @IBOutlet var isOnButton: BorderButton!
    
    @IBOutlet var speed: [BorderButton]!
    
    var currendSpeed: Int = 1
    var isOn: Bool {
        return isOnButton.isOn
    }
    
    var animation: UIDynamicAnimator!
    var itemBehavior: UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animation = UIDynamicAnimator(referenceView: view)
        isOnButton.isOn = false
        setSpeed()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func isOnTapped(_ sender: Any) {
        isOnButton.isOn = !isOn
        if isOn {
            setSpeed()
        } else {
            animation.removeBehavior(itemBehavior)
        }
    }
    
    @IBAction func speedTaped(_ sender: BorderButton) {
        currendSpeed = sender.tag
        setSpeed()
    }
    
    func setSpeed() {
        if isOn {
            if itemBehavior != nil {
                animation.removeBehavior(itemBehavior)
            }
            itemBehavior = UIDynamicItemBehavior(items: [fanBlade])
            
            itemBehavior.angularResistance = 0
            itemBehavior.allowsRotation = true
            itemBehavior.addAngularVelocity(CGFloat(10 * currendSpeed), for: fanBlade)
            animation.addBehavior(itemBehavior)
        }
        speed.forEach({$0.isOn = false})
        speed[currendSpeed - 1].isOn = true
        
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
