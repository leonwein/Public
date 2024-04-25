//
//  ClaimedOrderCell.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/22/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import Foundation
import UIKit

class ClaimedOrderCell: UITableViewCell{
    

    @IBOutlet weak var claimedByLabel: UILabel!
    
    @IBOutlet weak var restLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var TODLabel: UILabel!
    
    
 func setOrder(order: Order){
        restLabel.text = order.restaurant
        nameLabel.text = order.name
        TODLabel.text = order.timeOfDelivery
        claimedByLabel.text = order.claimedBy
    }
}


