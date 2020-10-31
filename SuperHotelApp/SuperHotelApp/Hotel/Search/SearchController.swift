//
//  SearchController.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 15/10/20.
//

import Foundation

class SearchController {
    
    var listHotel: [HotelElement] = []
    var hotel: HotelElement = HotelElement()
    var searchWorker = SearchWorker()
    var searchHotel: SearchModel?
    var currentSearch: String?
    
    func setupNavBar() -> String {
        return "Buscar"
    }
    
    var arrayCount: Int {
        return self.listHotel.count
    }
    
    func getLatitude(index: Int) -> Float {
        if let lat = Float(self.listHotel[index].latitude ?? "") {
            return lat
        }
            
        return 0
    }
    
    func getLongitude(index: Int) -> Float {
        
        if let long = Float(self.listHotel[index].longitude ?? "") {
            return long
        }
            
        return 0
    }
    
    func getName(index: Int) -> String {
        return self.listHotel[index].name ?? ""
    }
    
    func loadLocations(city: String?) {
        
        self.currentSearch = city
        
//        self.searchWorker.getListSearchAPI(completion: <#T##(SearchModel?, Bool) -> Void#>)
        //listHotel = MockHotel().listHotel(location: city ?? "")
    }
    
    
    func getListSearch(completion: @escaping (Bool) -> Void) {
        
        self.searchWorker.currentSearch(city: self.currentSearch ?? "")
        
        self.searchWorker.getListSearchAPI { (response, error) in
            if error == nil {
                self.searchHotel = response
                completion(true)
            } else {
                print("deu erro")
                completion(false)
            }
        }
    }
    
    func getQuantitySearchHotel() -> String {
        
        if self.arrayCount == 1 {
            return "\(arrayCount) hotel encontrado"
        } else {
            return "\(arrayCount) hotéis encontrados"
        }
    }
    
    func getMessageNotFoundHotel() -> String {
        return "Não encontramos hotéis para a cidade informada, tente novamente em outra cidade."
    }
    
    func getMessageNeedWrite() -> String {
        return "Para buscar um hotel é necessário preencher a cidade de destino."
    }
    
    func hotelSelected(annotation: String, index:Int) -> Bool {
        if self.listHotel[index].name == annotation {
            hotel = self.listHotel[index]
            return true
        }
        return false
    }

    
}
