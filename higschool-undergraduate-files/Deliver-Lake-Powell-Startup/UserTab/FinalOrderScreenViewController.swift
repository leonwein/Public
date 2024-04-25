//
//  FinalOrderScreenViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/24/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit

class FinalOrderScreenViewController: UIViewController {

    @IBOutlet weak var txtBox: UILabel!
    @IBOutlet weak var txtTitle: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTitle.text = "\(globName.name), Your order has been received!"
        txtBox.text = "We will call you when your order is ready!"
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    


}
