//
//  BookingWorker.swift
//  SuperHotelApp
//
//  Created by Elder Alcantara on 25/10/20.
//

import Foundation

class BookingWorker {
    
    func getListBooking( completion:(Booking?, Bool) -> Void) {
        
        if let path = Bundle.main.path(forResource: "booking", ofType: "json") {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decodeObject = try JSONDecoder().decode(Booking.self, from: data)
                
                print(decodeObject)
                completion(decodeObject, false)
                
            } catch {
                print("Erro ao carregar JSON! :(")
                completion(nil, true)
            }
        }
    }
    
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
