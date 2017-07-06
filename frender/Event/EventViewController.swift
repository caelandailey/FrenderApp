//
//  EventViewController.swift
//  frender
//
//  Created by Caelan Dailey on 5/19/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation

import Firebase
import FirebaseStorageUI
import JSQMessagesViewController

class EventViewController: UIViewController
{
    @IBOutlet weak var titleLabel:UILabel!
    
    
    @IBAction func test()
    {
        
       
        goToChatView()
    }
    
    @IBAction func test2()
    {
        
        
     goToProfileView()
    }
    @IBAction func test3()
    {
        
        
        goToGroupView()
    }
    
    func goToChatView()
    {
        let mainStoryboard = UIStoryboard(name: "ChatView", bundle: Bundle.main)
        let chatVc = mainStoryboard.instantiateViewController(withIdentifier: "ChatView") as! JSQMessagesViewController
        chatVc.senderDisplayName = "Caelan"
        
        //chatVc.senderId = Auth.auth().currentUser?.uid
        chatVc.senderId = "35235"
        self.present(chatVc, animated: true, completion: nil)
    }
    
    func goToProfileView()
    {
        let mainStoryboard = UIStoryboard(name: "ProfileView", bundle: Bundle.main)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProfileView") 
        vc.title = "87tz95pOThgb2k4Ep1tMO3pAO3G2" // Caelan Dailey's account id. Pretend clicking on my profile
        self.present(vc, animated: true, completion: nil)
    }
    
    func goToCreateGroupView()
    {
        let mainStoryboard = UIStoryboard(name: "GroupView", bundle: Bundle.main)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "CreateGroupView")
        vc.title = self.title
        self.present(vc, animated: true, completion: nil)
    }
    func goToGroupView()
    {
        let mainStoryboard = UIStoryboard(name: "GroupView", bundle: Bundle.main)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "GroupView")
        //vc.title = Database.database().reference().child("Event_List").child(self.title!).child("Groups").child("-KmMz2Dp75Gg2wFbjteS").key
            vc.title = "Event_List/\(self.title!)/Groups/-KmMz2Dp75Gg2wFbjteS"
            
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleLabel.text = self.title
    }

}
