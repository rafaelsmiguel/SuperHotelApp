//
//  HotelDetailController.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 15/10/20.
//

import Foundation

class HotelDetailController {
    
    private var hotel: HotelElement?
    
    init(hotel: HotelElement?) {
        self.hotel = hotel
    }
    
    var hotelName: String? {
        return self.hotel?.name
    }
    
    var valueByNight: String? {
        return Helper.transformToCurrency(value: self.hotel?.valueByNight ?? 0)
    }
    
    var address: String? {
        return self.hotel?.address
    }
    
    var image: String? {
        return self.hotel?.image
    }
    
    
    func getLatitude() -> Float {
        if let lat = Float(self.hotel?.latitude ?? "") {
            return lat
        }
            
        return 0
    }
    
    func getLongitude() -> Float {
        
        if let long = Float(self.hotel?.longitude ?? "") {
            return long
        }
            
        return 0
    }
    
    func getHotelDetail() -> HotelElement {
        return self.hotel ?? HotelElement()
    }
    
    func setupNavBar() -> String {
        return "Detalhes"
    }
    
}
