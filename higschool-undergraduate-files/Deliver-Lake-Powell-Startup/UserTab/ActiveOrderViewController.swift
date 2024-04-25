//
//  ActiveOrderViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/23/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class ActiveOrderViewController: UIViewController {
    
    
    @IBAction func btnCall(_ sender: Any) {
        guard let url = URL(string: "telprompt://4355926614") else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderFromLabel: UILabel!
    
    @IBOutlet weak var orderIDLabel: UILabel!
    
    @IBOutlet weak var orderStatusLabel: UILabel!
    
    @IBOutlet weak var statusImg: UIImageView!
    
    let group = DispatchGroup()
    var collectionNum: Int = 0
    
    private func setupNavigationBarItems() {
          
          let titleImageView = UIImageView(image: #imageLiteral(resourceName: "Deliver Logo"))
          titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
          titleImageView.contentMode = .scaleAspectFit
          let widthConstraint = titleImageView.widthAnchor.constraint(equalToConstant: 120)
          let heightConstraint = titleImageView.heightAnchor.constraint(equalToConstant: 48)
           heightConstraint.isActive = true
           widthConstraint.isActive = true
          navigationItem.titleView = titleImageView
    
          
      }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        statusImg.image = nil
        
        orderIDLabel.text = ""
        orderFromLabel.text = ""
        orderDateLabel.text = ""
        orderStatusLabel.text = "Loading..."
        checkCat(collection: "UnclaimedOrders")
        checkCat(collection: "ClaimedOrders")
        group.notify(queue: .main){
            if(self.collectionNum == 1){
                self.statusImg.image = UIImage(named: "lightOrangeStatusOrder")
                self.orderFromLabel.text = "Order From: \(String(UserDefaults.standard.string(forKey: "activeOrderRest")!))"
                self.orderIDLabel.text = "OrderID: \(String(UserDefaults.standard.string(forKey: "activeOrder")!))"
                self.orderDateLabel.text = "Time of Delivery: \(String(UserDefaults.standard.string(forKey: "activeOrderDate")!))"
                self.orderStatusLabel.text = "Your order has been processed!"
                
            }else if(self.collectionNum == 2){
                self.statusImg.image = UIImage(named: "lightOrangeStatusClaim")
                self.orderFromLabel.text = "Order From: \(String(UserDefaults.standard.string(forKey: "activeOrderRest")!))"
                self.orderIDLabel.text = "OrderID: \(String(UserDefaults.standard.string(forKey: "activeOrder")!))"
                self.orderDateLabel.text = "Time of Delivery: \(String(UserDefaults.standard.string(forKey: "activeOrderDate")!))"
                self.orderStatusLabel.text = "Your food is on its way!"
            }else{
                self.orderStatusLabel.text = "You have no active orders"
            }
        }
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
       

        
    }
    

        
        
        
   
    
    func checkCat (collection: String){
        
 
        group.enter()
        Firestore.firestore().collection(collection).getDocuments() { (querySnapshot, err) in
            
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in (querySnapshot?.documents)! {
                    
                    if let userDe = UserDefaults.standard.object(forKey: "activeOrder") as? String{
                        
                        if document.documentID == userDe && collection == "UnclaimedOrders"{
                            self.collectionNum = 1
                            
                            
                        }else if document.documentID == userDe && collection == "ClaimedOrders"{
                            self.collectionNum = 2
                            
                        }
                    }
                }
            }
            self.group.leave()
        }
        
        
    }
    
    
    
    
    
}
