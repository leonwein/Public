//
//  OTPViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/21/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class OTPViewController: UIViewController {


    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var passCheckLabel: UILabel!
    var pass: String = "1112"
    
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
        
        passField.becomeFirstResponder()
        passField.text = ""
        passCheckLabel.text = ""
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        
       let toolBar = UIToolbar()
            toolBar.sizeToFit()
            
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            
            let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
            
            toolBar.setItems([flexibleSpace, doneButton], animated: false)
            
            passField.inputAccessoryView = toolBar
            
            //listen for keyboard events
           
            
        }
        
        @objc func doneClicked() {
            view.endEditing(true)
            
            if passField.text == pass {
                passCheckLabel.text = ""
                
                //perform segue
                performSegue(withIdentifier: "unclaimedOrderSegue", sender: nil)
                
            }else{
                passCheckLabel.text = "Invalid ID"
                passField.text = ""
                passField.becomeFirstResponder()
            }
            
            
            
            //check if password is correct
            
        }
    
    func findCode(){
        
    
        
        Firestore.firestore().collection("DelivererPasscode").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in (querySnapshot?.documents)! {
                    
                    let dict = document.data()
                    
                    
                    for(key,value) in dict{
                        if key == "code" {
                            self.pass = value as! String
                        }
                    }
                }
            }
        }
    }
        
       
    override func viewWillAppear(_ animated: Bool) {
        findCode()
        passCheckLabel.text = ""
        passField.text = ""
        passField.becomeFirstResponder()
        //tf1.becomeFirstResponder()
    }
       
    
    
    @objc func dismissKeyboard() {
           //Causes the view (or one of its embedded text fields) to resign the first responder status.
           view.endEditing(true)
       }
    
    
   
    
    
    


}
