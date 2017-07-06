//
//  TestViewController.swift
//  frender
//
//  Created by Caelan Dailey on 6/1/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    
    
    @IBOutlet weak var blur2: UIVisualEffectView!
    @IBOutlet weak var blur1: UIVisualEffectView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blur1.layer.cornerRadius = 10;
        blur1.clipsToBounds = true;
        blur2.layer.cornerRadius = 10;
        blur2.clipsToBounds = true;
        
        
    }
}
