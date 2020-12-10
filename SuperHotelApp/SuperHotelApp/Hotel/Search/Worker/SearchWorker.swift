//
//  SearchNetwork.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 26/10/20.
//

import Foundation

class SearchWorker {
    
    var currentSearch: String?
    var destinationId: String?
    
    func currentSearch(city: String) {
        self.currentSearch = city
    }
    
    
//    func getListSearch( completion:(Hotel?, Bool) -> Void) {
//        
//        if let path = Bundle.main.path(forResource: "hotels", ofType: "json") {
//            
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let decodeObject = try JSONDecoder().decode(Hotel.self, from: data)
//                
//                print(decodeObject)
//                completion(decodeObject, false)
//                
//            } catch {
//                print("Erro ao carregar JSON! :(")
//                completion(nil, true)
//            }
//        }
//    }
    
    
    func getListSearchAPI( completion: @escaping (SearchModel?, _ error: Bool) -> Void) {
    
        var decodeObject: SearchModel?
        
        let headers = [
            "x-rapidapi-host": "hotels4.p.rapidapi.com",
            "x-rapidapi-key": "b6ef719826msh7b413b7790ce60ep18a365jsn5955326dd2c3"
        ]


        let queryItems = [URLQueryItem(name: "locale", value: "en_US"), URLQueryItem(name: "query", value: self.currentSearch!)]
        var urlComps = URLComponents(string: "https://hotels4.p.rapidapi.com/locations/search")!
        urlComps.queryItems = queryItems
        
//        let request1 = NSMutableURLRequest(url: NSURL(string: "https://hotels4.p.rapidapi.com/locations/search?locale=en_US&query=sao%20paulo")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
        
        let request = NSMutableURLRequest(url: urlComps.url ?? NSURL(string:"") as! URL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "")
            } else {
                _ = response as? HTTPURLResponse
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                
                let dataJson = responseData?.data(using: .utf8)!
                
                do {
                    decodeObject = try JSONDecoder().decode(SearchModel.self, from: dataJson!)
            
                    completion(decodeObject, false)
                    
                }catch {
                    print("erro")
                }
            }
        })

        dataTask.resume()
    }
    
    func getListHotel( completion: @escaping (PropertiesListModel?, _ error: Bool) -> Void) {
    
        var decodeObject: PropertiesListModel?
        
        let headers = [
            "x-rapidapi-host": "hotels4.p.rapidapi.com",
            "x-rapidapi-key": "b6ef719826msh7b413b7790ce60ep18a365jsn5955326dd2c3"
        ]


//        let queryItems = [URLQueryItem(name: "locale", value: "en_US"), URLQueryItem(name: "query", value: self.currentSearch!)]
//        var urlComps = URLComponents(string: "https://hotels4.p.rapidapi.com/locations/search")!
//        urlComps.queryItems = queryItems
//
////        let request1 = NSMutableURLRequest(url: NSURL(string: "https://hotels4.p.rapidapi.com/locations/search?locale=en_US&query=sao%20paulo")! as URL,
////                                                cachePolicy: .useProtocolCachePolicy,
////                                            timeoutInterval: 10.0)
//
//        let request = NSMutableURLRequest(url: urlComps.url ?? NSURL(string:"") as! URL)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
        
//        let request = NSMutableURLRequest(url: NSURL(string: "https://hotels4.p.rapidapi.com/properties/list?destinationId=1722487&pageNumber=1&checkIn=2020-01-08&checkOut=2020-01-15&pageSize=25&adults1=1&currency=USD&locale=en_US&sortOrder=PRICE")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
        
        let queryItems = [URLQueryItem(name: "destinationId", value: self.destinationId), URLQueryItem(name: "pageNumber", value: "1"), URLQueryItem(name: "checkIn", value: "2020-01-08"), URLQueryItem(name: "checkOut", value: "2020-01-15"), URLQueryItem(name: "pageSize", value: "25"), URLQueryItem(name: "adults1", value: "1"), URLQueryItem(name: "currency", value: "USD"), URLQueryItem(name: "locale", value: "en_US"), URLQueryItem(name: "sortOrder", value: "PRICE")]
        var urlComps = URLComponents(string: "https://hotels4.p.rapidapi.com/properties/list")!
        urlComps.queryItems = queryItems
        
        
        let request = NSMutableURLRequest(url: urlComps.url ?? NSURL(string:"") as! URL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "")
            } else {
                _ = response as? HTTPURLResponse
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                
                let dataJson = responseData?.data(using: .utf8)!
                
                do {
                    decodeObject = try JSONDecoder().decode(PropertiesListModel.self, from: dataJson!)
            
                    completion(decodeObject, false)
                    
                }catch {
                    print("erro")
                }
            }
        })

        dataTask.resume()
    }
    
    
}



