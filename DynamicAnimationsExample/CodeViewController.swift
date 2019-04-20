//
//  CodeViewController.swift
//  DynamicAnimationsExample
//
//  Created by farhad jebelli on 4/20/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit
var tapped: Int = 0

var unlocked = Array(repeating: false, count: 4)

class CodeViewController: UIViewController {

    var code: String = ""
    
    
    
    @IBOutlet var contaner: UIStackView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tapped >= 10 {
            contaner.isHidden = false
        }
    }
    
    func validate() -> Bool{
        switch code {
        case "1234":
            unlock(tag: 0)
        case "3441":
            unlock(tag: 1)
        case "2341":
            unlock(tag: 2)
        case "3423":
            unlock(tag: 3)
        default:
            return false
        }
        return true
    }
    
    func unlock(tag: Int) {
        unlocked[tag] = true
    }
    @IBAction func codeTapped(_ sender: UIButton) {
        code.append("\(sender.tag)")
        if code.count == 4 {
            if validate() {
                navigationController?.popViewController(animated: true)
            } else {
                code = ""
            }
        }
    }
    
    @IBAction func presenter(_ sender: Any) {
        tapped += 1
        if tapped == 10 {
            contaner.isHidden = false
        }
    }
    
}
