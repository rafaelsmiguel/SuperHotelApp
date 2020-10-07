//
//  Button.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 05/10/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit

class SHButton_FilledGreen: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        
        setupControl();
    }
    
    
    required override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        setupControl();
    }
    
    func setupControl()
    {
        super.titleLabel?.textAlignment = NSTextAlignment.center
        super.titleLabel?.font = UIFont(name: FontsName.regular, size: 18)
        super.setTitleColor(.white, for: UIControl.State.normal)
        super.backgroundColor = UIColor(red: 0.34, green: 0.82, blue: 0.76, alpha: 1)
        super.contentVerticalAlignment   = UIControl.ContentVerticalAlignment.center;
        super.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center;
        super.layer.cornerRadius = 20
        super.clipsToBounds = true
    }
}

class SHButton_FilledWhite: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        
        setupControl();
    }
    
    
    required override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        setupControl();
    }
    
    func setupControl()
    {
        super.titleLabel?.textAlignment = NSTextAlignment.center
        super.titleLabel?.font = UIFont(name: FontsName.regular, size: 18)
        super.setTitleColor(UIColor(red: 0.3, green: 0.3, blue: 0.31, alpha: 1), for: UIControl.State.normal)
        super.backgroundColor = .white
        super.contentVerticalAlignment   = UIControl.ContentVerticalAlignment.center;
        super.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center;
        super.layer.cornerRadius = 20
        super.layer.borderWidth = 1.3333333333333333
        super.layer.borderColor = UIColor(red: 0.55, green: 0.58, blue: 0.58, alpha: 1).cgColor
        super.clipsToBounds = true
    }
    
}
