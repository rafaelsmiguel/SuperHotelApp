//
//  MockHotel.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 08/10/20.
//

import Foundation
import Alamofire

class HotelDetailWorker {
    
    var hotelId: Int = 0
    
    func getHotelPhotos( completion: @escaping (HotelPhotos?, _ error: Bool) -> Void) {
        
        var decodeObject: HotelPhotos?
        
        let head: HTTPHeaders = ["x-rapidapi-host": "hotels4.p.rapidapi.com","x-rapidapi-key": "b6ef719826msh7b413b7790ce60ep18a365jsn5955326dd2c3"]
        
        var parametroPost: [String: Any]?
        
        let encoding: ParameterEncoding = JSONEncoding.default
        
        let queryItems = [URLQueryItem(name: "id", value: "\(hotelId)")]
        var urlComps = URLComponents(string: "https://hotels4.p.rapidapi.com/properties/get-hotel-photos")!
        urlComps.queryItems = queryItems
        
        AF.request(urlComps, method: HTTPMethod.get, parameters: parametroPost, encoding: encoding, headers: head).responseString(completionHandler: { response in
            
            switch(response.result) {
            
            case .success(let value):
                if let JSON = value as? String {
                    
                    let dataJson = JSON.data(using: .utf8)!
                    
                    do {
                        decodeObject = try JSONDecoder().decode(HotelPhotos.self, from: dataJson)
                        
                        completion(decodeObject, false)
                        
                    }catch {
                        print("erro")
                    }
                }
                break
                
            case .failure(let _):
                completion(nil, true);
                break
            }
        })
    }
}
