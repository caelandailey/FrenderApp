//
//  GroupViewController.swift
//  frender
//
//  Created by Caelan Dailey on 6/11/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class GroupViewController: UIViewController {
    
    
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupPhoto: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var test = "Coachella"
        
        let ref = Database.database().reference(withPath: self.title!)
        

        
        ref.observe(.value, with: { snapshot in
            print(snapshot)
            let snapshotValue = snapshot.value as! [String: AnyObject]
            self.groupTitle.text = snapshotValue["name"] as? String
            self.groupDescription.text = snapshotValue["description"] as? String
            
        })
        
    }
    
}
