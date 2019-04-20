//
//  ViewController.swift
//  DynamicAnimationsExample
//
//  Created by farhad jebelli on 4/19/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {


    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var cells: [UITableViewCell]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for (i,j) in unlocked.enumerated() {
            cells[i].isUserInteractionEnabled = j
            labels[i].isHidden = !j
        }
        
    }


}

