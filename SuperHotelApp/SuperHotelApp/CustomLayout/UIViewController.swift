//
//  UIViewController.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 08/10/20.
//

import UIKit

extension UIViewController {
    
    func showToast(message : String, showTop : Bool = false) {
        
        let widthBackground = self.view.frame.size.width-60
        let widthMessage = widthBackground-40
        
        let toastLabel = UILabel(frame: CGRect(x: ((widthBackground-widthMessage)/2), y: 10, width: widthMessage, height: 0))
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: FontsName.regular, size: 16.0)
        toastLabel.text = message
        toastLabel.lineBreakMode = .byWordWrapping
        toastLabel.numberOfLines = 0
        toastLabel.sizeToFit()
        toastLabel.frame = CGRect(x: ((widthBackground-toastLabel.frame.size.width)/2), y: 10, width: toastLabel.frame.size.width, height: toastLabel.frame.size.height)
        
        
        var yPosition = self.view.frame.size.height-100;
        
        if(showTop)
        {
            yPosition = 100;
        }
        
        let toastView = UIView(frame: CGRect(x: ((self.view.frame.size.width-widthBackground)/2), y: yPosition, width: widthBackground, height:toastLabel.frame.size.height+20))
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.alpha = 1.0
        toastView.layer.cornerRadius = 20;
        toastView.clipsToBounds  =  true
        
        toastView.addSubview(toastLabel)
        
        self.view.addSubview(toastView)
        
        UIView.animate(withDuration: 4.0, delay: 2.0, options: .curveEaseOut, animations: {
            toastView.alpha = 0.0
        }, completion: {(isCompleted) in
            toastView.removeFromSuperview()
        })
    }
    
    
}
