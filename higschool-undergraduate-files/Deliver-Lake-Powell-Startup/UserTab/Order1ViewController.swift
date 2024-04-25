//
//  Order1ViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/24/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit

class Order1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDest.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDest[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        destination = pickerDest[row]
    }
    

   
    @IBOutlet weak var restLabel: UILabel!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var txtDestination: UITextView!
    
    var pickerDest:[String] = [String]()
    var destination: String?
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    @IBAction func btnNext(_ sender: Any) {
        
        if(txtPhone.text != "" && txtName.text != "" && txtDestination.text != "" && txtDestination.text != "Info about destination\nEx. house boat, slip# 12"){
        globName.name = txtName.text!
        globPhone.name = txtPhone.text!
        globDestination.name = destination ?? ""
        globDestDes.name = txtDestination.text!
        performSegue(withIdentifier: "order2segue", sender: nil)
        }else{
            errorLabel.text = "Required Field/s are empty"
        }
        
    }
    
    @objc func dismissKeyboard() {
           //Causes the view (or one of its embedded text fields) to resign the first responder status.
           view.endEditing(true)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        
        setupNavigationBarItems()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        
        
        pickerDest = ["Whaweap", "Antelope"]
        
        txtDestination.text = "Info about destination\nEx. house boat, slip# 12"
        txtDestination.textColor = UIColor.lightGray
        txtDestination.layer.cornerRadius = 5
        txtDestination.layer.borderColor = UIColor.orange.cgColor
        txtDestination.layer.borderWidth = 1
        self.txtDestination.delegate = self
        
        textViewDidBeginEditing(txtDestination)
        textViewDidEndEditing(txtDestination)
        
        txtPhone.layer.cornerRadius = 5
        txtPhone.layer.borderColor = UIColor.orange.cgColor
        txtPhone.layer.borderWidth = 1
        
        txtName.layer.cornerRadius = 5
        txtName.layer.borderColor = UIColor.orange.cgColor
        txtName.layer.borderWidth = 1
        
        pickerView.layer.cornerRadius = 5
        pickerView.layer.borderColor = UIColor.orange.cgColor
        pickerView.layer.borderWidth = 1
        
        pickerView.selectRow(0, inComponent: 0, animated: true)
        destination = pickerDest[0]
        
        txtName.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        txtPhone.inputAccessoryView = toolBar
        txtDestination.inputAccessoryView = toolBar
        txtName.inputAccessoryView = toolBar
        //listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        restLabel.text = globRest.name
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        errorLabel.text = ""
    }
    
    
    
    
    //keyboard methods
    
    //UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtName.isEditing {
            txtName.resignFirstResponder()
        }else if txtPhone.isEditing{
            txtPhone.resignFirstResponder()
        }
        return true
    }
    
    
    @objc func keyboardWillChange(notification: Notification) {
        print("keyboard will show: \(notification.name.rawValue)")
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification{
            
            if txtName.isEditing {
                
            }else if txtPhone.isEditing{
                
            }else{
                view.frame.origin.y = -keyboardRect.height + (screenSize.height - (txtDestination.frame.origin.y + 200))
            }
            
        }else{
            view.frame.origin.y = 0
        }
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Info about destination\nEx. house boat, slip# 12"
            textView.textColor = UIColor.lightGray
           }
       }
    
    
    

   
}
