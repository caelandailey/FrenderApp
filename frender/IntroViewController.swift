//
//  SecondViewController.swift
//  frender
//
//  Created by Caelan Dailey on 6/3/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit
import JTMaterialTransition


class IntroViewController: UIViewController {
    
    
    @IBOutlet var presentLoginButton: UIButton!
    
    weak var presentControllerButton: UIView?
    var transition: JTMaterialTransition?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresentButtonFrame()
        
        createPresentControllerButton()
        self.transition = JTMaterialTransition(animatedView: self.presentControllerButton!)
    }
    
    
    func setupPresentButtonFrame()
    {

        presentLoginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        let size = CGSize(width: 0, height: 3)
        presentLoginButton.layer.shadowOffset = size
        presentLoginButton.layer.shadowOpacity = 1.0
        presentLoginButton.layer.shadowRadius = 0.0
        presentLoginButton.layer.masksToBounds = false
        presentLoginButton.layer.cornerRadius = 4.0
    }
    func createPresentControllerButton () {
        
        let y: CGFloat =  presentLoginButton.frame.origin.y
        let width: CGFloat = presentLoginButton.frame.size.height
        let height: CGFloat = width
        let x: CGFloat = presentLoginButton.frame.origin.x
        
        let presentControllerButton = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
        presentControllerButton.layer.cornerRadius = width / 2.0
        presentControllerButton.center = presentLoginButton.center
        presentControllerButton.backgroundColor = UIColor(red: 125 / 256.0, green: 186.0 / 256.0, blue: 255 / 256.0, alpha: 1.0)
        
        self.view.insertSubview(presentControllerButton, belowSubview: presentLoginButton)
        self.presentControllerButton = presentControllerButton
    }
    
    @IBAction func presentLoginButtonTouched () {
        
        let mainStoryboard = UIStoryboard(name: "LoginView", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginView") as UIViewController
        vc.transitioningDelegate = self.transition
        self.present(vc, animated: true, completion: nil)
    }

}
