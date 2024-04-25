//
//  ViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/17/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//
import UIKit
import iOSDropDown
import Firebase
import FirebaseFirestore
import SystemConfiguration
import SwiftUI


public class ViewController: UIViewController{
    
    
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var txtRest: UILabel!
    
    @IBOutlet weak var txtName: UILabel!
    
    @IBOutlet weak var txtPhone: UILabel!
    
    @IBOutlet weak var txtOrder: UITextView!
    
    @IBOutlet weak var txtPayment: UILabel!
    
    
    @IBOutlet weak var txtDoD: UILabel!
    
    @IBOutlet weak var txtToD: UILabel!
    
    @IBOutlet weak var txtLocation: UILabel!
    
    @IBOutlet weak var txtLocationInfo: UITextView!
    
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
    
    public override func viewWillAppear(_ animated: Bool) {
        
        txtRest.text = globRest.name
        txtName.text = globName.name
        txtPhone.text = globPhone.name
        txtOrder.text = globOrder.name
        txtPayment.text = globPayment.name
        txtDoD.text = globDateOfDelivery.name
        txtToD.text = globTimeOfDelivery.name
        txtLocation.text = globDestination.name
        txtLocationInfo.text = globDestDes.name
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItems()
        
        submitBtn.isEnabled = true
        
        //hide load indicator on start
        loadIndicator.hidesWhenStopped = true
        loadIndicator.stopAnimating()
        
 
        let db = Firestore.firestore()
        
        
        
           
    
    }
    
   //check if there is internet connection
    private func isNetworkReachable(with flags : SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        
        return isReachable && (!needsConnection || canConnectWithoutInteraction)
    }
    
    @objc private func callback() {
        performSegue(withIdentifier: "ordersegue", sender: nil)
        self.loadIndicator.stopAnimating()
    }
    
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func btn(_ sender: Any) {
        
        submitBtn.isEnabled = false
      
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.reachability!, &flags)
        
        //show load indicator
        loadIndicator.startAnimating()
        
        if self.isNetworkReachable(with: flags){
           
                   
            Firestore.firestore().collection("UnclaimedOrders").document(globOrderID.name).setData(["restaurant": globRest.name, "orderdes": globOrder.name, "name": globName.name, "phonenum" : globPhone.name, "paymentmeth" : globPayment.name, "timeofdelivery" : globTimeOfDelivery.name, "dateofdelivery": globDateOfDelivery.name, "location": globDestination.name, "destination": globDestDes.name])
            
            
            UserDefaults.standard.set(globOrderID.name, forKey: "activeOrder")
            UserDefaults.standard.set(globRest.name, forKey: "activeOrderRest")
            UserDefaults.standard.set("\(globDateOfDelivery.name) \(globTimeOfDelivery.name)", forKey: "activeOrderDate")
            tickDownSlot(date: globDateOfDelivery.name)
            //timer for loading indicator
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(callback), userInfo: nil, repeats: false)
            
            
        } else{
            self.loadIndicator.stopAnimating()
            createAlert(title: "NETWORK ERROR", message: "Please check wifi or cellular connection")
        }
        
 
    }
    
    
    func createAlert (title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tickDownSlot(date: String){
        
        Firestore.firestore().collection("TimeSlots").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in (querySnapshot?.documents)! {
                    
                    if document.documentID == date {
                        
                        document.reference.updateData([globTimeOfDelivery.name : document.get(globTimeOfDelivery.name) as! Int - 1])
            
                        
                    }
                }
            }
        }
    }
  
   
    
}
