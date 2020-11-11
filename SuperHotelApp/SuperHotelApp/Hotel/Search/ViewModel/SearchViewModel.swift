//
//  SearchController.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 15/10/20.
//

import Foundation

class SearchViewModel {
    
    var listHotel: [HotelElement] = []
    var hotel: HotelElement = HotelElement()
    var searchWorker = SearchWorker()
    var searchHotel: SearchModel?
    var currentSearch: String?
    var arraySuggestion: [Suggestion] = []
    var hotelsAPI: [Entities] = []
    var hotelAPI: Entities?
    
    func setupNavBar() -> String {
        return "Buscar"
    }
    
    var arrayCount: Int {
        return self.hotelsAPI.count
    }
    
    func getLatitude(index: Int) -> Float {
        if let lat = self.hotelsAPI[index].latitude ?? 0.0 {
            return Float(lat)
        }
            
        return 0
    }
    
    func getLongitude(index: Int) -> Float {
        
        if let long = self.hotelsAPI[index].longitude ?? 0.0 {
            return Float(long)
        }
            
        return 0
    }
    
    func getName(index: Int) -> String {
        return self.hotelsAPI[index].name ?? ""
    }
    
    func loadLocations(city: String?) {
        
        self.currentSearch = city
        
//        self.searchWorker.getListSearchAPI(completion: <#T##(SearchModel?, Bool) -> Void#>)
        //listHotel = MockHotel().listHotel(location: city ?? "")
        
        
        
        
    }
    
    
    func getListSearch(completion: @escaping (Bool) -> Void) {
        
        self.searchWorker.currentSearch(city: self.currentSearch ?? "")
        
        self.searchWorker.getListSearchAPI { (response, error) in
            if error == false {
                self.searchHotel = response as! SearchModel
                
                if self.searchHotel?.moresuggestions != 0 {
                    
                    if let suggestions = self.searchHotel?.suggestions {
                        self.arraySuggestion = suggestions.filter({$0.group == "HOTEL_GROUP"})
                        self.hotelsAPI = self.arraySuggestion[0].entities ?? []
                    }
                    
                    completion(true)
                } else {
                    completion(false)
                }
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
        if self.hotelsAPI[index].name == annotation {
            hotelAPI = self.hotelsAPI[index]
            return true
        }
        return false
    }
    
    func listaHotel(){
        
    }

    
}
