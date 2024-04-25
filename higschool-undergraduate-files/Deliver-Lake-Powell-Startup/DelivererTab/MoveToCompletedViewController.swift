//
//  MoveToCompletedViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/22/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class MoveToCompletedViewController: UIViewController {
    
    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var orderDesLabel: UITextView!
    @IBOutlet weak var paymentTypeLabel: UILabel!
    @IBOutlet weak var claimedByLabel: UILabel!
    @IBOutlet weak var dodLabel: UILabel!
    @IBOutlet weak var todLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var destinationLabel: UITextView!
    

    
    
    @IBAction func btnComplete(_ sender: Any) {
        //add document to claimedorders
        Firestore.firestore().collection("CompletedOrders").document(globSelectOrderID.name).setData(["name": nameLabel.text, "orderdes": orderDesLabel.text, "paymentmeth": paymentTypeLabel.text, "phonenum": phoneLabel.text, "restaurant": restLabel.text, "claimedby": claimedByLabel.text, "dateofdelivery": dodLabel.text, "timeofdelivery": todLabel.text, "location": locationLabel.text, "destination": destinationLabel.text])
        
        
            //delete document from unclaimedorders
        Firestore.firestore().collection("ClaimedOrders").document(globSelectOrderID.name).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        // Do any additional setup after loading the view.
    }
    

    func fetchData(){
        
        
        
     Firestore.firestore().collection("ClaimedOrders").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in (querySnapshot?.documents)! {
                    
                   // print(document.documentID)
                  
                    
                    if document.documentID == globSelectOrderID.name {
                        
                    
                        
                        self.orderIDLabel.text = globSelectOrderID.name
                        self.restLabel.text = (document.data()["restaurant"] as! String)
                        self.nameLabel.text = (document.data()["name"] as! String)
                        self.phoneLabel.text = (document.data()["phonenum"] as! String)
                        self.orderDesLabel.text = (document.data()["orderdes"] as! String)
                        self.paymentTypeLabel.text = (document.data()["paymentmeth"] as! String)
                        
                        self.claimedByLabel.text = (document.data()["claimedby"] as! String)
                        self.dodLabel.text = (document.data()["dateofdelivery"] as! String)
                        self.todLabel.text = (document.data()["timeofdelivery"] as! String)
                        self.locationLabel.text = (document.data()["location"] as! String)
                        self.destinationLabel.text = (document.data()["destination"] as! String)
                        
                        
                        
                        
                    }
                
                }
                
              
            }
        
       }
        
    }

}
