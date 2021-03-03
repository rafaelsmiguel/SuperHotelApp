//
//  RegisterViewModel.swift
//  SuperHotelApp
//
//  Created by Vitor Gomes on 12/11/20.
//

import Foundation

import UIKit

class RegisterViewModel{
    
    
    func clearAllFields(name:UITextField, from:UITextField, genre:UITextField, email:UITextField, birth:UITextField, password:UITextField, confirm:UITextField){
        
        name.text = nil
        from.text = nil
        genre.text = nil
        email.text = nil
        birth.text = nil
        password.text = nil
        confirm.text = nil
    }
    
    
    func registerArray(name:String, from:String, genre:String, email:String, birth:String, password:String, confirm:String, array: inout [User]){
        
        array.append(User(name: name, from: from, genre: genre, email: email, birth: birth, password: password, confirm: confirm))
        
    }
    
    func printRegister(array: inout [User]) {
        
        print("Registro Efetuado")
        print(array[0].email ?? "")
        print(array[0].password ?? "")

    }
    
    
    }

    
