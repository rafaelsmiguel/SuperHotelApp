//
//  SearchNetwork.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 26/10/20.
//

import Foundation

class SearchWorker {
    
    var currentSearch: String?
    
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
}



