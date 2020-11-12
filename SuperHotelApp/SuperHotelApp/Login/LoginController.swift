//
//  LoginController.swift
//  SuperHotelApp
//
//  Created by Vitor Gomes on 13/10/20.
//

import Foundation
import UIKit


class LoginController {
    
    
    func clearFields(fields:UITextField){
        
        fields.text = nil
        
    }
    
    
    func isEnable(bool:Bool, button:UIButton){
    
        if bool == true{
            
            button.isEnabled = true
        }else{
            
            button.isEnabled = false
        }
    }
    
    
    
    
    
    

}
