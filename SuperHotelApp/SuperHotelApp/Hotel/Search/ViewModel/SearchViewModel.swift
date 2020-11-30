//
//  SearchController.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 15/10/20.
//

import Foundation

class SearchViewModel {
    
//    var listHotel: [HotelElement] = []
//    var hotel: HotelElement = HotelElement()
    var searchWorker = SearchWorker()
    var searchHotel: SearchModel?
    var currentSearch: String?
    var arraySuggestion: [Suggestion] = []
    var locationsSearchAPI: [Entities] = []
    var entitieAPI: Entities?
    var propertiesListModel: PropertiesListModel?
    var listHotel: [Results] = []
    var resultHotel: Results?
    
    func setupNavBar() -> String {
        return "Buscar"
    }
    
    var arrayCount: Int {
        return self.listHotel.count
    }
    
    func getLatitude(index: Int) -> Double {
        if let lat = self.listHotel[index].coordinate?.lat {
            return Double(lat)
        }
            
        return 0
    }
    
    func getLongitude(index: Int) -> Double {
        
        if let long = self.listHotel[index].coordinate?.lon {
            return Double(long)
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
            if error == false {
                self.searchHotel = response as! SearchModel
                
                if self.searchHotel?.moresuggestions != 0 {
                    
                    if let suggestions = self.searchHotel?.suggestions {
                        self.arraySuggestion = suggestions.filter({$0.group == "LANDMARK_GROUP"})
                        self.locationsSearchAPI = self.arraySuggestion[0].entities ?? []
                        self.entitieAPI = self.locationsSearchAPI[0]
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
    
    func getListHotel(completion: @escaping (Bool) -> Void) {
        
        self.searchWorker.destinationId = self.entitieAPI?.destinationId
        
        self.searchWorker.getListHotel { (response, error) in
            if error == false {
                self.propertiesListModel = response as! PropertiesListModel
                
                if self.propertiesListModel?.result == "OK" {
                    
                    if let results = self.propertiesListModel?.data?.body?.searchResults?.results {
                        self.listHotel = results
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
        if self.listHotel[index].name == annotation {
            resultHotel = self.listHotel[index]
            return true
        }
        return false
    }
    
    func listaHotel(){
        
    }

    
}
