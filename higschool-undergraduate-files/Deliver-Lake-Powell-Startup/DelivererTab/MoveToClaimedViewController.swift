//
//  MoveToClaimedViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/21/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class MoveToClaimedViewController: UIViewController {

    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var orderDesLabel: UITextView!
    @IBOutlet weak var paymentTypeLabel: UILabel!
    
    @IBOutlet weak var doDLabel: UILabel!
    
    @IBOutlet weak var toDLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var destinationLabel: UITextView!
    
    
    @IBAction func btnClaim(_ sender: Any) {
        
        globalClaimedName.name = claimedName.text!
        
        //add document to claimedorders
        Firestore.firestore().collection("ClaimedOrders").document(globSelectOrderID.name).setData(["name": nameLabel.text, "orderdes": orderDesLabel.text, "paymentmeth": paymentTypeLabel.text, "phonenum": phoneLabel.text, "restaurant": restLabel.text, "claimedby": claimedName.text, "dateofdelivery": doDLabel.text, "timeofdelivery": toDLabel.text, "location": locationLabel.text, "destination": destinationLabel.text])
        
        
            //delete document from unclaimedorders
        Firestore.firestore().collection("UnclaimedOrders").document(globSelectOrderID.name).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        
    }
    @IBOutlet weak var claimedName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.dismissKeyboard))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        claimedName.inputAccessoryView = toolBar
       
        fetchData()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
       
        
        
        // Do any additional setup after loading the view.
    }
    
   
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func fetchData(){
        
        
        
     Firestore.firestore().collection("UnclaimedOrders").getDocuments() { (querySnapshot, err) in
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
                        self.doDLabel.text = (document.data()["dateofdelivery"] as! String)
                        self.toDLabel.text = (document.data()["timeofdelivery"] as! String)
                        self.locationLabel.text = (document.data()["location"] as! String)
                        self.destinationLabel.text = (document.data()["destination"] as! String)
                        
                        
                    }
                
                }
                
              
            }
        
       }
        
    }

}
