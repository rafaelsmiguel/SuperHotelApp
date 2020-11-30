//
//  SearchModel.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 28/10/20.
//

import Foundation

struct SearchModel: Codable {
    let term: String?
    let moresuggestions: Int?
    let autoSuggestInstance: String?
    let trackingID: String?
    let misspellingfallback: Bool?
    let suggestions: [Suggestion]?
}

struct Suggestion: Codable {
    let group: String?
    let entities: [Entities]?
}

struct Entities: Codable {
    let geoId: String?
    let destinationId: String?
    let landmarkCityDestinationId: String?
    let type: String?
    let caption: String?
    let redirectPage: String?
    let latitude: Double?
    let longitude: Double?
    let name: String?
}


struct LandMarkGroup {
    let destinationId: String
}
