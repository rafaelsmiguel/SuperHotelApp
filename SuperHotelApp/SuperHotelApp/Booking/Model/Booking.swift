//
//  BookingModel.swift
//  SuperHotelApp
//
//  Created by Elder Alcantara on 14/10/20.
//

import Foundation

// MARK: - Booking
struct Booking: Codable {
    let bookings: [BookingElement]
}

// MARK: - BookingElement
struct BookingElement: Codable {
    let hotelImage: String?
    let hotelName: String?
    let periodOfStay: String?
    let numberOfPeople: Int?
    let valueByNight: String?
    let amount: String?
    let address: String?
    let latitude: String?
    let longitude: String?
}
