//
//  Helper.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 09/10/20.
//

import Foundation

class Helper {
    
    static func transformToCurrency(value: Double) -> String
    {
        let number = NSDecimalNumber(decimal: Decimal(value))
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = "."
        numberFormatter.decimalSeparator = ","
        
        numberFormatter.locale = Locale(identifier: "pt_BR")
       
        if let result = numberFormatter.string(from: number)
        {
            return result
        }
        
        return ""
    }
    
    static func formatDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    static func saveInfoUserDefault(user: User) {
        
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(user) {
            defaults.set(encoded, forKey: "usuarioLogado")
        }
    }
    
    static func getLoggedUser() -> User {
        
        let defaults = UserDefaults.standard
        
        if let user = defaults.object(forKey: "usuarioLogado") as? Data {
            let decoder = JSONDecoder()
            if let loadUser = try? decoder.decode(User.self, from: user){
                
                return loadUser
            }
        }
        
        return User(name: "", from: "", genre: "", email: "", birth: "", password: "", confirm: "")
    }
    
    static func clearAllUserDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
}



