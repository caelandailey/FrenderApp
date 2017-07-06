//
//  ViewController.swift
//  frender
//
//  Created by Caelan Dailey on 4/29/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Firebase
import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn
import JTMaterialTransition
import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate{

    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var FacebookButton: FBSDKLoginButton!
    @IBOutlet weak var googleButton: GIDSignInButton!
    @IBOutlet weak var skipButton: UIButton!
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if (FBSDKAccessToken.current()) != nil {
            
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                }
        } 
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out of facebook")
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        print("Login button will login")
        return true
    }
    
    @IBAction func skipLogin()
    {
        goToMainView()
    }
    
    func goToMainView()
    {
        let mainStoryboard = UIStoryboard(name: "MainView", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainView") as UIViewController
       
        self.present(vc, animated: true, completion: nil)
        
//        let controller = mainStoryboard.instantiateViewController(withIdentifier: "MainView") as UIViewController
//        
//        controller.modalPresentationStyle = .custom
//        controller.transitioningDelegate = self.transition
//        
//        self.present(controller, animated: true, completion: nil)

    }
    
    func loginUser(email: String, password: String)
    {
        Auth.auth().signIn(withEmail: email,
                               password: password){ user, error in
                                if error == nil {
                                    Auth.auth().signIn(withEmail: email, password: email)
                                } else {
                                    print("Could NOT sign in. Error!")
                                    print(error ?? "Issue with error")
                                }
                                
        }
    }

    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
        
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .custom("user_birthday"),.custom("user_hometown") ], viewController: self) { loginResult in
            switch loginResult {
                
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                }
            }
        }
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        //myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }


    // Finished disconnecting |user| from the app successfully if |error| is |nil|.
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!){
        
    }
    
    func customizeUI()
    {
        skipButton.layer.cornerRadius = 5;
        skipButton.layer.borderWidth = 1;
        let myColor2: UIColor = UIColor.white
        skipButton.layer.borderColor = myColor2.cgColor
        skipButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        let size = CGSize(width: 0, height: 3)
        skipButton.layer.shadowOffset = size
        skipButton.layer.shadowOpacity = 1.0
        skipButton.layer.shadowRadius = 0.0
        skipButton.layer.masksToBounds = false
        
    
        
        FacebookButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        FacebookButton.layer.shadowOffset = size
        FacebookButton.layer.shadowOpacity = 1.0
        FacebookButton.layer.shadowRadius = 0.0
        FacebookButton.layer.masksToBounds = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent 
    }
    
    func addUser(){
        if Auth.auth().currentUser != nil
        {
            let user = Auth.auth().currentUser!
            let ref = Database.database().reference().child("Users").child(user.uid)
            ref.child("id").setValue(user.uid)
            ref.child("name").setValue(user.displayName)
            ref.child("email").setValue(user.email)
            
            if user.photoURL != nil {
                
                // Create a root reference
                let storageRef: StorageReference = Storage.storage().reference(forURL: "gs://fest-d1e89.appspot.com/")
                
  
                // File located on disk
                let localFile = user.photoURL!
                //let localFile = URL(fileURLWithPath: "http://searchengineland.com/figz/wp-content/seloads/2013/05/Screenshot_5_21_13_10_51_PM-2.png")
                // Create a reference to the file you want to upload
//                let riversRef = storageRef.child("Users").child(user.uid)
//
//                // Upload the file to the path "images/rivers.jpg"
//                let uploadTask = riversRef.putFile(from: localFile, metadata: nil) { metadata, error in
//                    if let error = error {
//                        // Uh-oh, an error occurred!
//                    } else {
//                        // Metadata contains file metadata such as size, content-type, and download URL.
//                        let downloadURL = metadata!.downloadURL()
//                    }
//                }
//                
                
                
            
                ref.child("photo").setValue(String(describing: localFile))
            }
            else
            {
                ref.child("photo").setValue("")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        FacebookButton.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            
                if user != nil {
                    // Did login/create account
                    self.addUser()
                    self.goToMainView() }
            
        }
    }
}

