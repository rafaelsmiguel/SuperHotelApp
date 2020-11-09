//
//  BookingViewModel.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 04/11/20.
//

import Foundation

class BookingViewModel {
    
    private var hotel: HotelModel?
    private var bookingRequest: BookingRequest = BookingRequest()
    
//    init(bookingRequest: BookingRequest?) {
//        self.bookingRequest = bookingRequest
//    }
    
//    init(hotel: HotelModel?) {
//        self.hotel = hotel
//    }
    
    var hotelName: String? {
        return self.hotel?.name
    }
    
    var checkIn:String? {
        return self.bookingRequest.checkIn
    }
    
    var checkOut:String? {
        return self.bookingRequest.checkOut
    }
    
    var adults: Int? {
        return self.bookingRequest.adults1
    }
    
    func setupNavBar() -> String {
        return "Reserva"
    }
    
    func maxAdultsForRoom() -> [Int] {
        
        var maxAdults = [Int]()
        
        for adult in 1...5 {
            maxAdults.append(adult)
        }
        
       return maxAdults
    }
    
    func formatDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    func setCheckin(checkIn:String) {
        bookingRequest.checkIn = checkIn
    }
    
    func setCheckout(checkOut:String) {
        bookingRequest.checkOut = checkOut
    }
    
    func setAdults(adults:Int) {
        bookingRequest.adults1 = adults
    }
    
}
