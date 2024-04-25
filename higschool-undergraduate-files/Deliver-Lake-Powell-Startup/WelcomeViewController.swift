//
//  WelcomeViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/26/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var holderView: UIView!
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        configure()
    }
    
    private func configure(){
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        let titles = ["Welcome, we're Deliver Lake Powell. A locally owned and operated food delivery service!", "Choose from a variety of restaurants in Page, AZ", "Plan ahead and select a delivery date thats right for you", "Submit your order", "View your order status live! we'll contact you when your order is ready for pickup"]
        
        for x in 0..<5 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x)*(holderView.frame.size.width), y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            
            scrollView.addSubview(pageView)
            
            //title, image, button
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width - 20, height: 120))
            
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10+100, width: pageView.frame.size.width - 20, height: pageView.frame.size.height - 60 - 130 - 15))
            
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height - 60, width: pageView.frame.size.width - 20, height: 50))
            
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont(name: "Avenir-Bold", size: 16)
            pageView.addSubview(label)
            label.text = titles[x]
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "welcome_\(x+1)")
            pageView.addSubview(imageView)
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .orange
            button.setTitle("Continue", for: .normal)
            if x == 4 {
                button.setTitle("Get Started", for: .normal)
            }
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            button.tag = x+1
            pageView.addSubview(button)
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width*5, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    @objc func didTapButton(_ button: UIButton){
        guard button.tag < 5 else{
            Core.shared.setIsNotNewUser()
            dismiss(animated: true, completion: nil)
            return
        }
        //scroll to next page
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width*CGFloat(button.tag),y: 0), animated: true)
    }
    
    


}
