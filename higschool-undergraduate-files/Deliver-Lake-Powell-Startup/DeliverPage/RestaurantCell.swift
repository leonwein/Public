//
//  RestaurantCell.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/20/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit
import SafariServices


protocol RestaurantCellDelegate {
    func didTapMenu(url: String)
}

class RestaurantCell: UITableViewCell{
    
    
    
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantTitleLabel: UILabel!
    
    var delegate: RestaurantCellDelegate?
    var restItem: Restaurant!
   
    @IBAction func menuTapped(_ sender: Any) {
        delegate?.didTapMenu(url: restItem.link)
    }
    
    
    
    func setRestaurant(restaurant: Restaurant){
        restItem = restaurant
        restaurantImageView.image = restaurant.image
        restaurantTitleLabel.text = restaurant.title
        restaurantImageView.layer.cornerRadius = 8.0
        restaurantImageView.layer.masksToBounds = true
       
    }
   
    
    
    
    

}
