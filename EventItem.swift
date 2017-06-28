//
//  EventItem.swift
//  frender
//
//  Created by Caelan Dailey on 5/29/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation
import Firebase


struct EventItem {
    
    let key: String
    let name: String
    let date: String
    let people: Int
    let groups: Int
    let ref: DatabaseReference?
    
    init(name: String, date: String, key: String = "", people: Int, groups: Int) {
        self.key = key
        self.name = name
        self.date = date
        self.people = people
        self.groups = groups
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        date = snapshotValue["date"] as! String
        people = snapshotValue["people"] as! Int
        groups = snapshotValue["groups"] as! Int
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "date": date,
            "people": people,
            "groups": groups
        ]
    }
    
}
