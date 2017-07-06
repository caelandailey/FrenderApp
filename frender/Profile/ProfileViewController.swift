//
//  ProfileViewController.swift
//  frender
//
//  Created by Caelan Dailey on 6/10/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorageUI
import FirebaseStorage

class ProfileViewController: UIViewController {
    var profileID = "";
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var sendMessageButton: UIButton!

    func loadImageFromUrl(url: String, view: UIImageView){
        
        // Create Url from string
        let url = NSURL(string: url)!
        
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        let task = URLSession.shared.dataTask(with: url as URL) { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
            if let data = responseData{
                
                // execute in UI thread
                DispatchQueue.main.async(execute: { () -> Void in
                    view.image = UIImage(data: data)
                    
                })
            }
        }
        
        // Run task
        task.resume()
    }

    func upload()
    {
        let storageRef = Storage.storage().reference()
        
//        // Create a reference to the file you want to upload
//        let riversRef = storageRef.child("profileImages")
//        let uploadTas = riversRef.
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = riversRef.putFile(data., metadata: nil) { (metadata, error) in
//            guard let metadata = metadata else {
//                // Uh-oh, an error occurred!
//                return
//            }
//            // Metadata contains file metadata such as size, content-type, and download URL.
//            let downloadURL = metadata.downloadURL
//        }
//        
        
        
        
        
        
        if let uploadData = UIImagePNGRepresentation(self.pictureView.image!) {
            
            
            
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error)
                    
                } else {
                    print("Image Uploaded Succesfully")
                    let profileImageUrl = metadata?.downloadURL()?.absoluteString
                }  
            })
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileID = self.title!;
        
        
        
        let  ref = Database.database().reference().child("Users").child(profileID)
        ref.observe(.value, with: { snapshot in
            print(snapshot)
            let snapshotValue = snapshot.value as! [String: AnyObject]
            self.nameLabel.text = snapshotValue["name"] as? String
            
            
            //self.imgURL = NSURL(string : snapshotValue["photo"] as! String)
            self.loadImageFromUrl(url: snapshotValue["photo"] as! String, view: self.pictureView)
            
        })
        
       
 
        upload()
    }
    
    
    
    
}
