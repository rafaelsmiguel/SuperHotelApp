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
}
