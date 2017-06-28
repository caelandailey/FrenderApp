//
//  TestViewController.swift
//  frender
//
//  Created by Caelan Dailey on 5/28/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn

class MainViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating
{
    var events: [EventItem] = []
    var eventsFilter: [EventItem]? = []
    
//    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var menuButton:UIBarButtonItem!
    let searchController = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            eventsFilter = events.filter { event in
                return event.name.lowercased().contains(searchText.lowercased())
            }
        } else {
            eventsFilter = events
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width/3
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            //menuButton.imageInsets = imageFrame
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        self.searchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        self.searchController.searchBar.isTranslucent = false
        let textFieldInsideSearchBar = self.searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.white
        self.searchController.searchBar.barTintColor = UIColor.white
        
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        //Sets up search bar
        eventsFilter = events
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        
        var  ref = Database.database().reference().child("Event_List")
        ref.observe(.value, with: { snapshot in
            // 2
            var newEvents: [EventItem] = []
            
            // 3
            for event in snapshot.children {
                // 4
                let eventItem = EventItem(snapshot: event as! DataSnapshot)
                newEvents.append(eventItem)
            }
            
            // 5
            self.events = newEvents
            self.tableView.reloadData()
        })
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return eventsFilter!.count
        }
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MainViewTableCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! MainViewTableCell
        
        let eventItem: EventItem
        if searchController.isActive && searchController.searchBar.text != "" {
            eventItem = eventsFilter![indexPath.row]
        } else {
            eventItem = events[indexPath.row]
        }

        cell.cellDate.text = eventItem.date
        cell.cellName.text = eventItem.name
        //cell.groupCount.text = String(eventItem.groups)
        //cell.peopleCount.text = String(eventItem.people)
        //cell.eventButton.addTarget(self, action: #selector(TestViewController.openEvent),
        //for: UIControlEvents.touchUpInside)
        let storage = Storage.storage()
        
        let ref = storage.reference(forURL: "gs://fest-d1e89.appspot.com/"+eventItem.name+".jpg")

        let placeholderImage = UIImage(named: "")
        cell.cellImage.sd_setImage(with: ref, placeholderImage: placeholderImage)

        return cell
    }
    
    func openEvent(_ name: String)
    {
        let mainStoryboard = UIStoryboard(name: "EventView", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "EventView") as UIViewController
        vc.title = name
        self.present(vc, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            events.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MainViewTableCell else { return }
        
        openEvent(cell.cellName.text!)
            }
    
    @IBAction func logout()
    {
        // Logout if firebase account
        let firebaseAuth = Auth.auth()
        do {
            try
                
                firebaseAuth.signOut()
            print("Logged out of firebase")
            
            // Logout if facebook
            if (FBSDKAccessToken.current() != nil)
            {
                let loginManager = FBSDKLoginManager()
                loginManager.logOut() // this is an instance function
                print("Logged out of facebook")
            }
            GIDSignIn.sharedInstance().signOut()
            print("Logged out of Google")
            
            goToLoginView()
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
        
    }
    func goToLoginView()
    {
        let mainStoryboard = UIStoryboard(name: "LoginView", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginView") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}
