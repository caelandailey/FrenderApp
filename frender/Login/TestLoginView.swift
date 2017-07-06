//
//  TestLoginView.swift
//  frender
//
//  Created by Caelan Dailey on 5/31/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn

class TestloginView: UIViewController
{
    @IBOutlet weak var blurView2: UIView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var FacebookButton: FBSDKLoginButton!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let myColor: UIColor = UIColor.white
        skipButton.layer.borderColor = myColor.cgColor
        //skipButton.layer.borderWidth = 1
        skipButton.layer.cornerRadius = 5;
        loginButton.layer.cornerRadius = 5;
        blurView.layer.cornerRadius = 5;
        //blurView2.layer.cornerRadius = 5;
        blurView.clipsToBounds = true;
    }
    
    
    
    
}
