//
//  HotelModel.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 08/10/20.
//

import Foundation

struct HotelModel {
    var destinationId: String?
    var name: String?
    var latitude: Double?
    var longitude: Double?
    var valueByNight: Double?
    var address: String?
    var images: [String]?
    var starRating: Int?
}

struct GetDetails: Codable {
    var result: String
    var data: DataDetails
}

struct DataDetails: Codable {
    var body: BodyDetails
}

struct BodyDetails: Codable {
    var pdpHeader: PdpHeader
    var propertyDescription: PropertyDescription
}

struct PdpHeader: Codable {
    var hotelId: String
    var destinationId: String
    var hotelLocation: HotelLocation
}

struct HotelLocation: Codable {
    var coordinates: Coordinates
}

struct Coordinates: Codable {
    var latitude: Float
    var longitude: Float
}

struct PropertyDescription: Codable {
    var address: Address
    var name: String
    var starRating: Int
    var featuredPrice: FeaturedPrice
}

struct Address: Codable {
    var cityName: String
    var provinceName: String
    var addressLine1: String
    var fullAddress: String
}

struct FeaturedPrice: Codable {
    var currentPrice: CurrentPrice
    var oldPrice: String
}

struct CurrentPrice: Codable {
    var plain: Int
}
