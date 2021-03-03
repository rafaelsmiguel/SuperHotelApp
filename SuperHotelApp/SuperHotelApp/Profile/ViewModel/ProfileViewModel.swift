//
//  ProfileViewModel.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 01/02/21.
//

import Foundation

class ProfileViewModel {
    
    private var user: User?
    
    func getLoggedUser(){
        self.user = Helper.getLoggedUser()
    }
    
    var name: String {
        return self.user?.name ?? ""
    }
    
    var nationality: String {
        return self.user?.from ?? ""
    }
    
    var genre: String {
        return self.user?.genre ?? ""
    }
    
    var birth: String {
        return self.user?.birth ?? ""
    }
    
    var email: String {
        return self.user?.email ?? ""
    }
    
    func clearAllUserDefaults() {
        Helper.clearAllUserDefaults()
    }
    
   
}
