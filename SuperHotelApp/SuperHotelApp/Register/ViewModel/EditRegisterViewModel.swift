//
//  EditRegisterViewModel.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 01/02/21.
//

import Foundation

class EditRegisterViewModel {
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var name: String {
        return self.user.name
    }
    
    var nationality: String {
        return self.user.from
    }
    
    var genre: String {
        return self.user.genre
    }
    
    var birth: String {
        return self.user.birth
    }
    
    var email: String {
        return self.user.email
    }
    
    func formatDate(date: Date) -> String {
        return Helper.formatDate(date: date)
    }
    
    func setName(name:String) {
        user.name = name
    }
    
    func setNationality(nationality:String) {
        user.from = nationality
    }
    
    func setGenre(genre:String) {
        user.genre = genre
    }
    
    func setBirth(birth:String) {
        user.birth = birth
    }
    
    func setEmail(email:String) {
        user.email = email
    }
    
    func verifyEmptyFields() -> String {
        
        if user.name == "" {
            return "O campo nome deve ser preenchido."
        } else if user.from == "" {
            return "O campo nacionalidade deve ser preenchido."
        } else if user.genre == "" {
            return "O campo gênero deve ser preenchido."
        } else if user.birth == "" {
            return "O campo data de nascimento deve ser preenchido."
        } else if user.email == "" {
            return "O campo e-mail deve ser preenchido."
        } else {
            return ""
        }
    }
    
    func saveInfoUserDefault() {
        Helper.saveInfoUserDefault(user: self.user)
    }
}
