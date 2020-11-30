//
//  HotelPhotos.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 22/11/20.
//

import Foundation

struct HotelPhotos: Codable {
    
    let hotelId: Int?
    let hotelImages: [ImagesHotel]?
}

class ImagesHotel: Codable {
    let baseUrl: String?
    let imageId: Int?
}
