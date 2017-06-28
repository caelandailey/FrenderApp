//
//  MainViewTableCell.swift
//  frender
//
//  Created by Caelan Dailey on 5/29/17.
//  Copyright © 2017 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit

class MainViewTableCell: UITableViewCell {
    
    @IBOutlet weak var cellDate: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    
    
    @IBOutlet weak var eventButton: UIButton!
    
    @IBOutlet weak var cellName: UILabel!
    
    @IBOutlet weak var groupCount: UILabel!
    @IBOutlet weak var peopleCount: UILabel!
}
