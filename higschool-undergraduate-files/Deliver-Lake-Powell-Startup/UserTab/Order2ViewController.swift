//
//  Order2ViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/24/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit
import SafariServices

class Order2ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBAction func btnNext(_ sender: Any) {
        if(txtOrder.text != "" && txtOrder.text != "1x ferruccine alfredo\n2x 12 piece chicken wings mild sauce\n3x large pepironi pizza"){
            globOrder.name = txtOrder.text
            performSegue(withIdentifier: "order3segue", sender: nil)
        }else{
           errorLabel.text = "Required Field/s are empty"
        }
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        showSafariVC(for: globMenuLink.name)
    }
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else{
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
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
    
    @IBOutlet weak var txtOrder: UITextView!
    
    override func viewDidLoad() {
        
        setupNavigationBarItems()
        
        restLabel.text = globRest.name
        errorLabel.text = ""
        super.viewDidLoad()
        txtOrder.delegate = self
        textViewDidBeginEditing(txtOrder)
        textViewDidEndEditing(txtOrder)
        
        txtOrder.text = "1x ferruccine alfredo\n2x 12 piece chicken wings mild sauce\n3x large pepironi pizza"
        txtOrder.textColor = UIColor.lightGray
        txtOrder.layer.cornerRadius = 5
        txtOrder.layer.borderColor = UIColor.orange.cgColor
        txtOrder.layer.borderWidth = 1
    
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.dismissKeyboard))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        txtOrder.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    //add placeholder
    
    override func viewWillAppear(_ animated: Bool) {
       errorLabel.text = ""
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "1x ferruccine alfredo\n2x 12 piece chicken wings mild sauce\n3x large pepironi pizza"
            textView.textColor = UIColor.lightGray
        }
    }
    

  

}
