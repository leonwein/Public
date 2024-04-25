//
//  ClaimedViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/22/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ClaimedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unwindToClaimedList(_ sender: UIStoryboardSegue){}
   var orders: [Order] = []
        
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            globalClaimedName.name = ""
            globSelectOrderID.name = ""
            
   
        }
        

        
        override func viewWillAppear(_ animated: Bool) {
            orders.removeAll()
            Firestore.firestore().collection("ClaimedOrders").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in (querySnapshot?.documents)! {
                        let data = document.data()
                        let restaurant = data["restaurant"] as? String ?? "Anonymous"
                        let name = data["name"] as? String ?? "Anonymous"
                        let tod = data["timeofdelivery"] as? String ?? "Anonymous"
                        let orderId = document.documentID
                        let claimedBy = data["claimedby"] as? String ?? "Anonymous"
                        let date = data["dateofdelivery"] as? String ?? "Anonymous"
                            
                        let newOrder = Order(restaurant: restaurant, name: name, timeOfDelivery: tod, claimedBy: claimedBy, orderID: orderId, date: date)
                        
                        self.orders.append(newOrder)
                        
                       
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
        
        
        
            
        }
    extension ClaimedViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let order = orders[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClaimedOrderCell") as! ClaimedOrderCell
            
            cell.setOrder(order: order)
            
            return cell
        }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tableView.deselectRow(at: indexPath, animated: true)
        globSelectOrderID.name = orders[indexPath.row].orderID
        performSegue(withIdentifier: "claimedSegue", sender: nil)
        
        
    }
    


}
