//
//  BookingWorker.swift
//  SuperHotelApp
//
//  Created by Elder Alcantara on 25/10/20.
//

import Foundation

class BookingWorker {
    
    
    func getListBookingUserDefault(completion:([BookingElement]?,Bool) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let bookings = defaults.object(forKey: "reservas") as? Data {
            
          let decoder = JSONDecoder()
            
          if let loadBooking = try? decoder.decode([BookingElement].self, from: bookings) {
            completion(loadBooking,false)
            
          } else {
            completion(nil, true)
          }
        
        } else {
            completion(nil, true)
        }
        
    }
    
    
}
