//
//  User.swift
//  SuperHotelApp
//
//  Created by Vitor Gomes on 13/10/20.
//

import Foundation


class User: Codable{
    
    var name:String
    var from:String
    var genre:String
    var email:String
    var birth:String
    var password:String
    var confirm:String
    
    
    init(name:String, from:String, genre:String, email:String, birth:String, password:String, confirm:String){
        
        self.name = name
        self.from = from
        self.genre = genre
        self.email = email
        self.birth = birth
        self.password = password
        self.confirm = confirm
        
    }
    
    
}
