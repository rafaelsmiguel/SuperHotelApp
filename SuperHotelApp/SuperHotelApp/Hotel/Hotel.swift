//
//  HotelModel.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 08/10/20.
//

import Foundation

// MARK: - Hotel
struct Hotel: Codable {
    let hotels: [HotelElement]
}

// MARK: - HotelElement
struct HotelElement: Codable {
    var destinationId: String?
    var name: String?
    var latitude: String?
    var longitude: String?
    var valueByNight: Double?
    var address: String?
    var image: String?
}
