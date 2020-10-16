//
//  SearchController.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 15/10/20.
//

import Foundation

class SearchController {
    
    var listHotel: [HotelModel] = []
    var hotel: HotelModel = HotelModel()
    
    func setupNavBar() -> String {
        return "Buscar"
    }
    
    var arrayCount: Int {
        return self.listHotel.count
    }
    
    func getLatitude(index: Int) -> Float {
        if let lat = Float(self.listHotel[index].latitude ?? "") {
            return lat
        }
            
        return 0
    }
    
    func getLongitude(index: Int) -> Float {
        
        if let long = Float(self.listHotel[index].longitude ?? "") {
            return long
        }
            
        return 0
    }
    
    func getName(index: Int) -> String {
        return self.listHotel[index].name ?? ""
    }
    
    func loadLocations(city: String?) {
        listHotel = MockHotel().listHotel(location: city ?? "")
    }
    
    func hotelSelected(annotation: String, index:Int) -> Bool {
        if self.listHotel[index].name == annotation {
            hotel = self.listHotel[index]
            return true
        }
        return false
    }

    
}
