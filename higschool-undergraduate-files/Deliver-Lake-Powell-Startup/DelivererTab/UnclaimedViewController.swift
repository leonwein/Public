//
//  UnclaimedViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/21/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class UnclaimedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
   
   
    
    @IBAction func unwindToUnclaimedList(_ sender: UIStoryboardSegue){}
    
    
    
    var orders: [Order] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //orders = createArray()
        globSelectOrderID.name = ""
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        

        // Do any additional setup after loading the view.
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        orders.removeAll()
        Firestore.firestore().collection("UnclaimedOrders").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in (querySnapshot?.documents)! {
                    let data = document.data()
                    let restaurant = data["restaurant"] as? String ?? "Anonymous"
                    let name = data["name"] as? String ?? "Anonymous"
                    let tod = data["timeofdelivery"] as? String ?? "Anonymous"
                    let orderId = document.documentID
                    let date = data["dateofdelivery"] as? String ?? "Anonymous"
                        
                    let newOrder = Order(restaurant: restaurant, name: name, timeOfDelivery: tod, claimedBy: "", orderID: orderId, date: date)
                    
                    self.orders.append(newOrder)
                    
                   
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    
        
    }
extension UnclaimedViewController: UITableViewDataSource, UITableViewDelegate{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return orders.count
}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = orders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrderCell
        
        cell.setOrder(order: order)
        
        return cell
    }
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    tableView.deselectRow(at: indexPath, animated: true)
    globSelectOrderID.name = orders[indexPath.row].orderID 
    performSegue(withIdentifier: "moveToClaimedSegue", sender: nil)
    
    
    
    
    
}
    
    
    
    
    
    

  

}
