//
//  MockHotel.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 08/10/20.
//

import Foundation

class MockHotel {
    
    func listHotel(location: String) -> [HotelElement] {
        
        var listHotel:[HotelElement] = []
        
        var hotel1 = HotelElement()
        var hotel2 = HotelElement()
        var hotel3 = HotelElement()
        
        
        if location == "São Paulo" {
            hotel2 = HotelElement(destinationId: "2", name: "Hotel Marriot", latitude: "-23.560640", longitude: "-46.650570",valueByNight: 192.00, address: "Avenida Raimundo 287 - Pirituba - São Paulo - SP",image: "hotel1.jpg")
            hotel3 = HotelElement(destinationId: "3", name: "Hotel Liberda", latitude: "-23.5612621", longitude: "-46.6532267",valueByNight: 300.00, address: "Avenida Paulista 232 - Jardim Paulista - São Paulo - SP",image: "hotel2.jpg")
            hotel1 = HotelElement(destinationId: "1", name: "Hotel Hilton", latitude: "-23.5617561", longitude: "-46.6519259",valueByNight: 500.00, address: "Avenida Hadock Lobo 1500 - Centro - São Paulo - SP",image: "hotel3.jpg")
        }
        else if location == "Rio de Janeiro" {
            
            hotel2 = HotelElement(destinationId: "2", name: "Hotel Rio Lindo", latitude: "-22.9704375", longitude: "-43.1872733",valueByNight: 400.00, address: "Avenida Leblon 900 - Leblon - Rio de Janeiro - RJ",image: "hotel4.jpg")
            hotel3 = HotelElement(destinationId: "3", name: "Hotel Rio das Pedra", latitude: "-22.9699748", longitude: "-43.1873121",valueByNight: 370.00, address: "Avenida Rio das Pedras 23 - Botafogo - Rio de Janeiro - RJ",image: "hotel3.jpg")
            hotel1 = HotelElement(destinationId: "1", name: "Hotel Copacabana", latitude: "-22.9700485", longitude: "-43.1868448",valueByNight: 950.00, address: "Avenida Copacabana 107 - Copacabana - Rio de Janeiro - RJ",image: "hotel5.jpg")
        } else {
            hotel2 = HotelElement(destinationId: "2", name: "Hotel Marriot", latitude: "-23.560640", longitude: "-46.650570",valueByNight: 192.00, address: "Avenida Raimundo 287 - Pirituba - São Paulo - SP",image: "hotel1.jpg")
            hotel3 = HotelElement(destinationId: "3", name: "Hotel Liberda", latitude: "-23.5612621", longitude: "-46.6532267",valueByNight: 300.00, address: "Avenida Paulista 232 - Jardim Paulista - São Paulo - SP",image: "hotel2.jpg")
            hotel1 = HotelElement(destinationId: "1", name: "Hotel Hilton", latitude: "-23.5617561", longitude: "-46.6519259",valueByNight: 500.00, address: "Avenida Hadock Lobo 1500 - Centro - São Paulo - SP",image: "hotel3.jpg")
            //return listHotel
        }
        
        listHotel.append(hotel2)
        listHotel.append(hotel3)
        listHotel.append(hotel1)
        
        return listHotel
        
    }
    
}
