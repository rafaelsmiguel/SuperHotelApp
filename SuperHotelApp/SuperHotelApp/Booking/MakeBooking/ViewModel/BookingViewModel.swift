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
    private var bookingElement: BookingElement?
    private var aBookingElement: [BookingElement] = []
    
//    init(bookingRequest: BookingRequest?) {
//        self.bookingRequest = bookingRequest
//    }
    
    init(hotel: HotelModel?) {
        self.hotel = hotel
    }

    var hotelName: String? {
        return self.hotel?.name
    }
    
    var valueByNightFormat: String? {
        return Helper.transformToCurrency(value: self.hotel?.valueByNight ?? 0)
    }
    
    func periodOfStay() -> String {
        
        if let checkIn = self.checkIn, let checkOut = self.checkOut {
            return "De \(checkIn) até \(checkOut)"
        }
        
        return ""
    }
    
    func amount() -> String {
        
        var amount = 0.0
        
        if let valueByNight = self.hotel?.valueByNight {
            
            let quantityDays = self.quantityDays()
            
            amount = (Double(quantityDays) * valueByNight) * Double(self.adults ?? 0)
        }
        
        return Helper.transformToCurrency(value: amount)
    }
    
    func quantityDays() -> Int {
        
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: checkInDate)
        let date2 = calendar.startOfDay(for: checkOutDate)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        return components.day ?? 0
    }
    
    var address: String? {
        return self.hotel?.address
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
    
    func getStars() -> Int {
        return self.hotel?.starRating ?? 0
    }
    
    var checkInDate: Date {
        
        let dateString = self.bookingRequest.checkIn ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale.init(identifier: "pt_BR")

       return dateFormatter.date(from: dateString) ?? Date()
    }
    
    var checkOutDate: Date {
        
        let dateString = self.bookingRequest.checkOut ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale.init(identifier: "pt_BR")

        return dateFormatter.date(from: dateString) ?? Date()
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
    
    func fillInfoBooking() {
        
        self.bookingElement = BookingElement(hotelImage: self.hotel?.images?[0] ?? "", hotelName: self.hotelName, periodOfStay: self.periodOfStay(), numberOfPeople: self.adults, valueByNight: self.valueByNightFormat, amount: self.amount(), address: self.address, latitude: self.hotel?.latitude, longitude: self.hotel?.longitude ,starRating: self.getStars())
        
        self.saveInfoUserDefault()
        
    }
    
    func saveInfoUserDefault() {
            
            let defaults = UserDefaults.standard
            let encoder = JSONEncoder()
            
            if let bookings = defaults.object(forKey: "reservas") as? Data {
                let decoder = JSONDecoder()
                if let loadBooking = try? decoder.decode([BookingElement].self, from: bookings) {
                    aBookingElement = loadBooking
                    
                    if let bookingElement = self.bookingElement {
                        aBookingElement.append(bookingElement)
                        if let encoded = try? encoder.encode(aBookingElement) {
                            defaults.set(encoded, forKey: "reservas")
                        }
                    }
                } else {
                    
                }
            } else {
                
                if let bookingElement = self.bookingElement{
                    aBookingElement.append(bookingElement)
                    
                    if let encoded = try? encoder.encode(aBookingElement) {
                        defaults.set(encoded, forKey: "reservas")
                    }
                }
            }
        }
}
