//
//  MockHotel.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 08/10/20.
//

import Foundation

class HotelDetailWorker {
    
    var hotelId: Int = 0
    
//    func listHotel(location: String) -> [HotelModel] {
//        
//        var listHotel:[HotelModel] = []
//        
//        var hotel1 = HotelModel()
//        var hotel2 = HotelModel()
//        var hotel3 = HotelModel()
//        
//        
//        if location == "São Paulo" {
//            hotel2 = HotelModel(destinationId: "2", name: "Hotel Marriot", latitude: -23.560640, longitude: -46.650570,valueByNight: 192.00, address: "Avenida Raimundo 287 - Pirituba - São Paulo - SP",images: ["hotel1.jpg","hotel2.jpg","hotel3.jpg","hotel4.jpg"])
//            hotel3 = HotelModel(destinationId: "3", name: "Hotel Liberda", latitude: -23.5612621, longitude: -46.6532267,valueByNight: 300.00, address: "Avenida Paulista 232 - Jardim Paulista - São Paulo - SP",images: ["hotel1.jpg","hotel2.jpg","hotel3.jpg","hotel4.jpg"])
//            hotel1 = HotelModel(destinationId: "1", name: "Hotel Hilton", latitude: -23.5617561, longitude: -46.6519259,valueByNight: 500.00, address: "Avenida Hadock Lobo 1500 - Centro - São Paulo - SP",images: ["hotel1.jpg","hotel2.jpg","hotel3.jpg","hotel4.jpg"])
//        }
//        else if location == "Rio de Janeiro" {
//            
//            hotel2 = HotelModel(destinationId: "2", name: "Hotel Rio Lindo", latitude: -22.9704375, longitude: -43.1872733,valueByNight: 400.00, address: "Avenida Leblon 900 - Leblon - Rio de Janeiro - RJ",images: ["hotel1.jpg","hotel2.jpg","hotel3.jpg","hotel4.jpg"])
//            hotel3 = HotelModel(destinationId: "3", name: "Hotel Rio das Pedra", latitude: -22.9699748, longitude: -43.1873121,valueByNight: 370.00, address: "Avenida Rio das Pedras 23 - Botafogo - Rio de Janeiro - RJ",images: ["hotel1.jpg","hotel2.jpg","hotel3.jpg","hotel4.jpg"])
//            hotel1 = HotelModel(destinationId: "1", name: "Hotel Copacabana", latitude: -22.9700485, longitude: -43.1868448,valueByNight: 950.00, address: "Avenida Copacabana 107 - Copacabana - Rio de Janeiro - RJ",images: ["hotel1.jpg","hotel2.jpg","hotel3.jpg","hotel4.jpg"])
//        } else {
//            hotel2 = HotelModel(destinationId: "2", name: "Hotel Marriot", latitude: -23.560640, longitude: "-46.650570",valueByNight: 192.00, address: "Avenida Raimundo 287 - Pirituba - São Paulo - SP",images: ["hotel1.jpg","hotel2.jpg"])
//            hotel3 = HotelModel(destinationId: "3", name: "Hotel Liberda", latitude: "-23.5612621", longitude: "-46.6532267",valueByNight: 300.00, address: "Avenida Paulista 232 - Jardim Paulista - São Paulo - SP",images: ["hotel1.jpg","hotel2.jpg","hotel3.jpg"])
//            hotel1 = HotelModel(destinationId: "1", name: "Hotel Hilton", latitude: "-23.5617561", longitude: "-46.6519259",valueByNight: 500.00, address: "Avenida Hadock Lobo 1500 - Centro - São Paulo - SP",images: ["hotel1.jpg"])
//            //return listHotel
//        }
//        
//        listHotel.append(hotel2)
//        listHotel.append(hotel3)
//        listHotel.append(hotel1)
//        
//        return listHotel
//        
//    }
    
    func getHotelDetailAPI( completion: @escaping (GetDetails?, _ error: Bool) -> Void) {
        
        var decodeObject: GetDetails?
        
        
        let headers = [
            "x-rapidapi-key": "b6ef719826msh7b413b7790ce60ep18a365jsn5955326dd2c3",
            "x-rapidapi-host": "hotels4.p.rapidapi.com"
        ]
        
        //        let queryItems = [URLQueryItem(name: "locale", value: "en_US"), URLQueryItem(name: "query", value: self.currentSearch!)]
        //        var urlComps = URLComponents(string: "https://hotels4.p.rapidapi.com/locations/search")!
        //        urlComps.queryItems = queryItems
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://hotels4.p.rapidapi.com/properties/get-details?id=424023&locale=en_US&currency=USD&checkOut=2020-01-15&adults1=1&checkIn=2020-01-08")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
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
                    decodeObject = try JSONDecoder().decode(GetDetails.self, from: dataJson!)
                    
                    completion(decodeObject, false)
                    
                }catch {
                    print("erro")
                }
            }
        })
        
        dataTask.resume()
    }
    
    func getHotelPhotos( completion: @escaping (HotelPhotos?, _ error: Bool) -> Void) {
        
        var decodeObject: HotelPhotos?
        
        
        let headers = [
            "x-rapidapi-key": "b6ef719826msh7b413b7790ce60ep18a365jsn5955326dd2c3",
            "x-rapidapi-host": "hotels4.p.rapidapi.com"
        ]
        
        let queryItems = [URLQueryItem(name: "id", value: "\(hotelId)")]
        var urlComps = URLComponents(string: "https://hotels4.p.rapidapi.com/properties/get-hotel-photos")!
        urlComps.queryItems = queryItems
        
//        let request = NSMutableURLRequest(url: NSURL(string: "https://hotels4.p.rapidapi.com/properties/get-details?id=424023&locale=en_US&currency=USD&checkOut=2020-01-15&adults1=1&checkIn=2020-01-08")! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
        
        
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
                    decodeObject = try JSONDecoder().decode(HotelPhotos.self, from: dataJson!)
                    
                    completion(decodeObject, false)
                    
                }catch {
                    print("erro")
                }
            }
        })
        
        dataTask.resume()
    }
    
    
}
