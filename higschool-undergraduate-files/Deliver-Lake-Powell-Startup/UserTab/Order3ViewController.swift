//
//  Order3ViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/24/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class Order3ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var loadSlotIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var paymentPicker: UIPickerView!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var timePicker: UIPickerView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func btnNext(_ sender: Any) {
        if(txtDate.text != "" && selectedTime != ""){
        globPayment.name = selectedPayment!
        globDateOfDelivery.name = selectedDate!
        globTimeOfDelivery.name = selectedTime!
        errorLabel.text = ""
        performSegue(withIdentifier: "summarysegue", sender: nil)
        }else{
            errorLabel.text = "Required Field/s are empty"
        }
        
    }
    
    let datePicker = UIDatePicker()
    
    
    var pickerData:[String] = [String]()
    var pickerTime:[String] = [String]()
    
    let group = DispatchGroup()
    
    override func viewWillAppear(_ animated: Bool) {
        errorLabel.text = ""
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
        
        setupNavigationBarItems()
        
        restLabel.text = globRest.name
        
        createDatePicker()
      
        loadSlotIndicator.stopAnimating()
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
        self.paymentPicker.delegate = self
        self.paymentPicker.dataSource = self
        
        paymentPicker.tag = 0
        timePicker.tag = 1
        
        timePicker.layer.cornerRadius = 5
        timePicker.layer.borderColor = UIColor.orange.cgColor
        timePicker.layer.borderWidth = 1
        
        paymentPicker.layer.cornerRadius = 5
        paymentPicker.layer.borderColor = UIColor.orange.cgColor
        paymentPicker.layer.borderWidth = 1
        
        txtDate.layer.cornerRadius = 5
        txtDate.layer.borderColor = UIColor.orange.cgColor
        txtDate.layer.borderWidth = 1
        
        
        pickerData = ["Cash", "Credit", "Venmo"]
        
        paymentPicker.selectRow(1, inComponent: 0, animated: true)
        selectedPayment = pickerData[0]
        
        timePicker.selectRow(0, inComponent: 0, animated: true)
        selectedTime = ""
        selectedDate = ""
        errorLabel.text = ""
        
        
        
    }
    
    
    //payment picker
    var selectedPayment: String?
    var selectedTime: String?
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        if pickerView.tag == 0{
            return pickerData.count
        } else if pickerView.tag == 1{
            return pickerTime.count
        }
        return 0
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         
        if pickerView.tag == 0{
            return pickerData[row]
        } else if pickerView.tag == 1{
            return pickerTime[row]
        }
        return ""
        
                   
               
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerView.tag)
        
        if pickerView.tag == 0{
            selectedPayment = pickerData[row]
        } else if pickerView.tag == 1{
            if pickerTime.count > 0{
                selectedTime = pickerTime[row]
                
                getOrderID()
                
                
                
            }
        }
    }
    
    func getOrderID() {
        let rndNumber : Int = Int.random(in: 1...300)
        
        let n = selectedTime?.replacingOccurrences(of: "pm", with: "") ?? "1"
        let hour = Int(n)
        
        let date = datePicker.calendar.date(byAdding: .hour, value: hour ?? 1, to: datePicker.date)
        
        let interval = date?.timeIntervalSince1970
        
        globOrderID.name = String(Int(interval!) + rndNumber)
        
    }
    
    
    
    func createDatePicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        //assign toolbar
        txtDate.inputAccessoryView = toolbar
        //assign dat picker to the text field
        txtDate.inputView = datePicker
        //date picker mode
        datePicker.datePickerMode = .date
        //set min and max date
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 14, to: Date())
    }
    var selectedDate: String?

    @objc func donePressed(){
        
        pickerTime.removeAll()
       
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        txtDate.text = formatter.string(from: datePicker.date)
        selectedDate = txtDate.text
        fetchData(date: txtDate.text ?? "")
        self.view.endEditing(true)
        loadSlotIndicator.startAnimating()
        
        group.notify(queue: .main){
            
            //sort array
            self.pickerTime = self.pickerTime.sorted {$0.localizedStandardCompare($1) == .orderedAscending}
            print(self.pickerTime)
            
            let currentHour = Calendar.current.component(.hour, from: Date())
            
            for s in self.pickerTime {
                let sCut = s.replacingOccurrences(of: "pm", with: "")
                let sInt = Int(sCut)
                if sInt! + 12 < currentHour + 2 && Calendar.current.component(.day, from: Date()) == Calendar.current.component(.day, from: self.datePicker.date) {
                self.pickerTime.removeAll(where: {$0 == s})
                }
                
                
            }
            
            
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            //let minutes = calendar.component(.minute, from: date)
            print(Int(hour))
            
            
           
            
            self.loadSlotIndicator.stopAnimating()
            self.timePicker.reloadAllComponents()
            self.timePicker.selectRow(0, inComponent: 0, animated: true)
            if self.pickerTime.count > 0{
                self.selectedTime = self.pickerTime[0]
                self.errorLabel.text =  ""
                self.getOrderID()
            }else{
                self.selectedTime = ""
                self.errorLabel.text =  "There are no available time slots available for this date"
            }
            
        }
        
        //Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(callback), userInfo: nil, repeats: false)
        
        
        //find slots with given date
        
        
        
    }
    
    

    
    
    func fetchData(date: String){
        group.enter()
        Firestore.firestore().collection("TimeSlots").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in (querySnapshot?.documents)! {
                    
                    if document.documentID == date {
                        
                        let dict = document.data()
                        
                       
                            for(key,value) in dict{
                                print("value")
                                if(value as! Int > 0){
                                    self.pickerTime.append(key)
                                    
                                }
                            }
                        
                    }
                }
                self.group.leave()
                
            }
        }
    }
    
    
    
    
  
    
    
    
    
    
}
