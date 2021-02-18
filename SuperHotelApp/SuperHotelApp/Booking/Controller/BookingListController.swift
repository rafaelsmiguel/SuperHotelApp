//
//  BookingListController.swift
//  SuperHotelApp
//
//  Created by Elder Alcantara on 25/10/20.
//

import Foundation
import UIKit

class BookingListController {
    
    let navigationBarTitle: String = "Reservas"
    
    
//    var arrayBookings: Booking?
    var aBooking: [BookingElement]?
    var booking: BookingElement?
    
    
    var numberOfBookings: Int {
        return aBooking?.count ?? 0
    }
    
    
//    var bookingImage: UIImage {
//        return UIImage(named: self.booking?.hotelImage ?? "") ?? UIImage()
//        print(self.booking?.hotelImage)
//    }
    
    var bookingImage: String {
        return self.booking?.hotelImage ?? ""
    }
    
    
    var bookingName: String {
        return self.booking?.hotelName ?? ""
    }
    
    var bookingPeriod: String {
        return self.booking?.periodOfStay ?? ""
    }
    
    var bookingPeople: Int {
        return self.booking?.numberOfPeople ?? 0
    }
    
    var bookingValueByNight: String {
        return self.booking?.valueByNight ?? ""
    }
    
    var bookingAmount: String {
        return self.booking?.amount ?? ""
    }
    
    var bookingAddress: String {
        return self.booking?.address ?? ""
    }
   
    var bookingLatitude: Double {
        return self.booking?.latitude ?? 0.0
    }
    
    var bookingLongitude: Double {
        return self.booking?.longitude ?? 0.0
    }
    
    func getListBookingUserDefault(completion: (Bool) -> Void) {
        
        BookingWorker().getListBookingUserDefault { (bookings, error) in
            
            if error == false {
                
                self.aBooking = bookings
                completion(true)
                
            } else {
                
                completion(false)
                print("Erro no parse do JSON")
                
            }
            
        }
        
    }
    
    
    func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        let url = URL(string: self.bookingImage)
            
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error fetching the image!")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
            
        dataTask.resume()
    }
    
    
}
