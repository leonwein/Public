//
//  CustomMenuButton.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/28/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import Foundation
import UIKit

class CustomMenuButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
        //setShadow()
        setTitleColor(.white, for: .normal)
        
        //backgroundColor      = UIColor.orange
        titleLabel?.font     = UIFont(name: "AvenirNext-Bold", size: 18)
        //titleLabel?.shadowColor = .black
        //titleLabel?.shadowOffset = CGSize(width: 2.0, height: -1.0)
    
        layer.cornerRadius   = 8.0
        layer.borderWidth    = 2.0
        layer.borderColor    = UIColor.white.cgColor
    }
    
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 2.0, height: -1.0)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    
    func shake() {
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 2
        shake.autoreverses  = true
        
        let fromPoint       = CGPoint(x: center.x - 8, y: center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)
        
        let toPoint         = CGPoint(x: center.x + 8, y: center.y)
        let toValue         = NSValue(cgPoint: toPoint)
        
        shake.fromValue     = fromValue
        shake.toValue       = toValue
        
        layer.add(shake, forKey: "position")
    }
}
