//
//  GroupViewController.swift
//  frender
//
//  Created by Caelan Dailey on 6/10/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CreateGroupViewController: UIViewController {
    
    
    @IBOutlet weak var groupPhoto: UIImageView!
    @IBOutlet weak var cancelGroup: UIButton!
    
    
    @IBOutlet weak var groupDescription: JVFloatLabeledTextField!
    @IBOutlet weak var groupTitle: JVFloatLabeledTextField!
    
    @IBAction func createGroup()
    {
        if (groupTitle.text == nil)
        {
            print("errror")
        }
        if Auth.auth().currentUser != nil
        {
            //Group key is user ID
            // Should we make it a random ID?
            // Add ID key to players list of groups
            
            let userKey = Auth.auth().currentUser?.uid
            let ref = Database.database().reference().child("Event_List").child(self.title!).child("Groups").childByAutoId()
            
            ref.child("name").setValue(groupTitle.text)
            ref.child("description").setValue(groupDescription.text)
            ref.child("admins").setValue(userKey)
            
            let userRef = Database.database().reference().child("Users").child((userKey)!)
            userRef.child("Groups").child(ref.key).setValue(ref.key)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }
}
