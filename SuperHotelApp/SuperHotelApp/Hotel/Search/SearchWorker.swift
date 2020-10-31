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
    
    func getListSearch( completion:(Hotel?, Bool) -> Void) {
        
        if let path = Bundle.main.path(forResource: "hotels", ofType: "json") {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decodeObject = try JSONDecoder().decode(Hotel.self, from: data)
                
                print(decodeObject)
                completion(decodeObject, false)
                
            } catch {
                print("Erro ao carregar JSON! :(")
                completion(nil, true)
            }
        }
    }
    
    
    func getListSearchAPI( completion:(SearchModel?, Bool) -> Void) {
    
        var decodeObject: SearchModel?
        
        let headers = [
            "x-rapidapi-host": "hotels4.p.rapidapi.com",
            "x-rapidapi-key": "b6ef719826msh7b413b7790ce60ep18a365jsn5955326dd2c3"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://hotels4.p.rapidapi.com/locations/search?locale=en_US&query=sao%20paulo")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                
                let dataJson = responseData?.data(using: .utf8)!
                
                do {
                    decodeObject = try JSONDecoder().decode(SearchModel.self, from: dataJson!)
            
                    print(decodeObject)
                }catch {
                    print("erro")
                }


                print(responseData ?? "")
            }
        })

        dataTask.resume()
        
        if decodeObject == nil {
            completion(decodeObject,false)
        } else {
            completion(nil, true)
        }
    }
}



