//
//  SearchNetwork.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 26/10/20.
//

import Foundation
import Alamofire

class SearchWorker {
    
    var currentSearch: String?
    var destinationId: String?
    
    func currentSearch(city: String) {
        self.currentSearch = city
    }
    
    func getListSearchAPIAF( completion: @escaping (SearchModel?, _ error: Bool) -> Void) {
    
        var decodeObject: SearchModel?
        
        let head: HTTPHeaders = ["x-rapidapi-host": "hotels4.p.rapidapi.com","x-rapidapi-key": "b6ef719826msh7b413b7790ce60ep18a365jsn5955326dd2c3"]
        
        var parametroPost: [String: Any]?
        
        let encoding: ParameterEncoding = JSONEncoding.default
        
        let queryItems = [URLQueryItem(name: "locale", value: "en_US"), URLQueryItem(name: "query", value: self.currentSearch!)]
        var urlComps = URLComponents(string: "https://hotels4.p.rapidapi.com/locations/search")!
        urlComps.queryItems = queryItems
        
        AF.request(urlComps, method: HTTPMethod.get, parameters: parametroPost, encoding: encoding, headers: head).responseString(completionHandler: { response in
            
            switch(response.result) {
            
            case .success(let value):
                if let JSON = value as? String {
                    
                    let dataJson = JSON.data(using: .utf8)!
                    
                    do {
                        decodeObject = try JSONDecoder().decode(SearchModel.self, from: dataJson)
                
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

    func getListHotelAF(completion: @escaping (PropertiesListModel?, _ error: Bool) -> Void) {
        var decodeObject: PropertiesListModel?
        
        let head: HTTPHeaders = ["x-rapidapi-host": "hotels4.p.rapidapi.com","x-rapidapi-key": "b6ef719826msh7b413b7790ce60ep18a365jsn5955326dd2c3"]
        
        var parametroPost: [String: Any]?
        
        let encoding: ParameterEncoding = JSONEncoding.default
        
        
        let queryItems = [URLQueryItem(name: "destinationId", value: self.destinationId), URLQueryItem(name: "pageNumber", value: "1"), URLQueryItem(name: "checkIn", value: "2020-01-08"), URLQueryItem(name: "checkOut", value: "2020-01-15"), URLQueryItem(name: "pageSize", value: "25"), URLQueryItem(name: "adults1", value: "1"), URLQueryItem(name: "currency", value: "USD"), URLQueryItem(name: "locale", value: "en_US"), URLQueryItem(name: "sortOrder", value: "PRICE")]
        var urlComps = URLComponents(string: "https://hotels4.p.rapidapi.com/properties/list")!
        urlComps.queryItems = queryItems
        
        AF.request(urlComps, method: HTTPMethod.get, parameters: parametroPost, encoding: encoding, headers: head).responseString(completionHandler: { response in
            
            switch(response.result) {
            
            case .success(let value):
                if let JSON = value as? String {
                    
                    let dataJson = JSON.data(using: .utf8)!
                    
                    do {
                        decodeObject = try JSONDecoder().decode(PropertiesListModel.self, from: dataJson)
                
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



