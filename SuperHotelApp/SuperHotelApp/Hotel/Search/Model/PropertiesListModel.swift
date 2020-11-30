//
//  PropertiesListModel.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 22/11/20.
//

import Foundation

class PropertiesListModel: Codable {
    let result: String?
    let data: DataAPI?
}

class DataAPI: Codable {
    let body: Body?
}

class Body: Codable {
//    let header: String?
//    let query: Query?
    let searchResults: SearchResults?
}

class SearchResults: Codable {
    let totalCount: Int?
    let results: [Results]?
}

struct Results: Codable {
    let id: Int?
    let name: String?
    let thumbnailUrl: String?
    let starRating: Double?
    let address: AddressResult?
    let ratePlan: RatePlan?
    let coordinate: Coordinate?
}

class AddressResult: Codable {
    let streetAddress: String?
    let extendedAddress: String?
    let locality: String?
    let postalCode: String?
    let region: String?
    let countryName: String?
    let countryCode: String?
}

class RatePlan: Codable {
    let price: Price?
    let features: Feature?
    let type: String?
}

class Price: Codable {
    let current: String?
    let exactCurrent: Double?
}

class Feature: Codable {
    let freeCancellation: Bool?
    let paymentPreference: Bool?
    let noCCRequired: Bool?
}

class Coordinate: Codable {
    let lat: Double?
    let lon: Double?
}
