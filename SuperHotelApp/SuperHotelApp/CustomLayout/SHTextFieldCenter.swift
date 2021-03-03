//
//  SHTextFieldCenter.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 30/11/20.
//

import UIKit

class SHTextFieldCenter: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0);
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        
        setupControl();
    }
    
    func setupControl()
    {
        super.borderStyle = .none
        super.font = UIFont(name: FontsName.regular, size: 18)
        super.backgroundColor = .white
        super.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.31, alpha: 1)
//        super.attributedPlaceholder = NSAttributedString(string: super.placeholder!,
//                                                         attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): Estilo.Cores.cinzaClaro]))
        
        super.textAlignment = NSTextAlignment.center
        super.borderStyle = .none
        
        super.layer.cornerRadius = 24
        super.layer.borderWidth = 0
        super.clipsToBounds = true
        
        //super.tintColor = Estilo.Cores.principal
//        super.layer.borderColor = Estilo.Cores.cinzaBorda.cgColor
        super.layer.masksToBounds = true
        
        super.autocapitalizationType = .sentences
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
