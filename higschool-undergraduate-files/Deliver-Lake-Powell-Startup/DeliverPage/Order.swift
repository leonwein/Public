//
//  Order.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/21/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//
import Foundation
import UIKit
class Order {
    var restaurant: String
    var name: String
    var timeOfDelivery: String
    var claimedBy: String
    var orderID: String
    var date: String
    
    init(restaurant: String, name: String, timeOfDelivery: String, claimedBy: String, orderID: String, date: String){
        self.restaurant = restaurant
        self.name = name
        self.timeOfDelivery = timeOfDelivery
        self.claimedBy = claimedBy
        self.orderID = orderID
        self.date = date
        
    }
    
    
}
