//
//  OrderCell.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/21/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import Foundation
import UIKit

class OrderCell: UITableViewCell{
    
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var TODLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    func setOrder(order: Order){
        restLabel.text = order.restaurant
        nameLabel.text = order.name
        TODLabel.text = order.timeOfDelivery
        dateLabel.text = order.date
    }
}
