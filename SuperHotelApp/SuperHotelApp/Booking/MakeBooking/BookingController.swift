//
//  BookingController.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 15/10/20.
//

import Foundation

class BookingController {
    
    private var hotel: HotelModel?
    
    init(hotel: HotelModel?) {
        self.hotel = hotel
    }
    
    var hotelName: String? {
        return self.hotel?.name
    }
    
    func setupNavBar() -> String {
        return "Reserva"
    }
    
}
