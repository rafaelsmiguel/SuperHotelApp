//
//  HotelDetailController.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 15/10/20.
//

import Foundation

class HotelDetailViewModel {
    
    private var hotel: HotelModel?
    var hotelDetailWorker = HotelDetailWorker()
    var getDetails: GetDetails?
    
    init(hotel: HotelModel?) {
        self.hotel = hotel
    }
    
    var hotelName: String? {
        return self.getDetails?.data.body.propertyDescription.name
    }
    
    var valueByNight: String? {
        return Helper.transformToCurrency(value: Double(self.getDetails?.data.body.propertyDescription.featuredPrice.currentPrice.plain ?? 0))
    }
    
    var address: String? {
        return self.getDetails?.data.body.propertyDescription.address.fullAddress
    }
    
    var images: [String]? {
        return self.hotel?.images
    }
    
    
    func getLatitude() -> Float {
        if let lat = self.getDetails?.data.body.pdpHeader.hotelLocation.coordinates.latitude {
            return lat
        }
            
        return 0
    }
    
    func getLongitude() -> Float {
        
        if let long = self.getDetails?.data.body.pdpHeader.hotelLocation.coordinates.longitude {
            return long
        }
            
        return 0
    }
    
    func getHotelDetail() -> HotelModel {
        return self.hotel ?? HotelModel()
    }
    
    func setupNavBar() -> String {
        return "Detalhes"
    }
    
    func getHotelDetailAPI(completion: @escaping (Bool) -> Void) {
        
        //            self.hotelDetailWorker.currentSearch(city: self.currentSearch ?? "")
        
        self.hotelDetailWorker.getHotelDetailAPI { (response, error) in
            if error == false {
                
                self.getDetails = response!
                
                if self.getDetails?.result == "OK" {
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                print("deu erro")
                completion(false)
            }
        }
    }
    
    
    
    
    
}
