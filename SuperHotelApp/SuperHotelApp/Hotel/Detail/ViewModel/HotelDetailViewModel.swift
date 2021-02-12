//
//  HotelDetailController.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 15/10/20.
//

import Foundation

class HotelDetailViewModel {
    
    private var hotel: Results?
    var hotelDetailWorker = HotelDetailWorker()
    var getDetails: GetDetails?
    var hotelPhotos: HotelPhotos?
    var mainPhotoURL: [String]?
    
    init(hotel: Results?) {
        self.hotel = hotel
    }
    
    var hotelName: String? {
        return self.hotel?.name
    }
    
    var valueByNight: Double? {
        return self.hotel?.ratePlan?.price?.exactCurrent ?? 0
    }
    
    var valueByNightFormat: String? {
        return Helper.transformToCurrency(value: self.hotel?.ratePlan?.price?.exactCurrent ?? 0)
    }
    
    var address: String? {
        return self.hotel?.address?.extendedAddress
    }
    
    var images: [ImagesHotel]? {
        return hotelPhotos?.hotelImages
    }
    
    func getLatitude() -> Double {
        if let lat = self.hotel?.coordinate?.lat {
            return lat
        }
            
        return 0
    }
    
    func getLongitude() -> Double {
        
        if let long = self.hotel?.coordinate?.lon {
            return long
        }
            
        return 0
    }
    
    func getHotelDetail() -> Results {
        return self.hotel ?? Results(id: 0, name: "", thumbnailUrl: "", starRating: 0.0, address: nil, ratePlan: nil, coordinate: nil)
    }
    
    func setupNavBar() -> String {
        return "Detalhes"
    }
    
    func getHotelPhotos(completion: @escaping (Bool) -> Void) {
        
        self.hotelDetailWorker.hotelId = self.hotel?.id ?? 0
        
        self.hotelDetailWorker.getHotelPhotos { (response, error) in
            if error == false {
                
                self.hotelPhotos = response!
                
                if self.hotelPhotos != nil {
                    self.getMainPhoto()
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
    
    func getMainPhoto() {
        
        if let hotelPhotos = self.hotelPhotos {
            if let hotelImages = hotelPhotos.hotelImages {
                if hotelImages.count > 0 {
                    if let url = hotelImages[0].baseUrl?.replacingOccurrences(of: "{size}", with: "y") {
                        self.mainPhotoURL = [String]()
                        self.mainPhotoURL?.append(url)
                    }
                }
            }
        }
    }
    
    func getStars() -> Int {
        return Int(self.hotel?.starRating?.rounded() ?? 0)
    } 
}
