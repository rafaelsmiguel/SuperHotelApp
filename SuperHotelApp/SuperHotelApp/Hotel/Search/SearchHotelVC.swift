//
//  SearchHotelVC.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit
import MapKit

class SearchHotelVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchTextField: SHTextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var destinationId: String = ""
    var listHotel: [HotelModel] = []
    var hotelSelected: HotelModel = HotelModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
        
        mapView.delegate = self
        
        resultLabel.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
 
    func setupNavBar() {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = "Buscar"
        
    }

    func setupTextField() {
            
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "procurar.png"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(searchTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        searchTextField.rightView = button
        searchTextField.rightViewMode = .always
        
    }
    
    func setPins() {
        
        listHotel = MockHotel().listHotel(location: searchTextField.text ?? "")
        
        if !listHotel.isEmpty {
            
            for item in listHotel {
                
                let annotation = MKPointAnnotation()
                
                guard let lat = Float(item.latitude ?? "") else {
                    return
                }
                
                guard let long = Float(item.longitude ?? "") else {
                    return
                }
                
                annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
                annotation.title = item.name
                mapView.addAnnotation(annotation)
                
                let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
                mapView.setRegion(region, animated: true)
            }
            
            resultLabel.isHidden = false
            resultLabel.text = "\(listHotel.count) Hotéis encontrados!"
            
        } else {
            self.showToast(message: "Não encontramos hotéis para a cidade informada, tente novamente em outra cidade.",showTop: true)
            return
        }
    }

    @IBAction func refresh(_ sender: Any) {
        
        fecharTeclado(searchTextField)
        
        if searchTextField.text?.count == 0 {
            self.showToast(message: "Para buscar um hotel é necessário preencher a cidade de destino.",showTop: true)
            return
        }
        
        setPins()
    }
    
    @IBAction func fecharTeclado(_ sender: UITextField) {
        
        searchTextField.resignFirstResponder()
    }
}

extension SearchHotelVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let annotation = view.annotation {
            
            for itemHotel in listHotel {
                if itemHotel.name == annotation.title {
                    hotelSelected = itemHotel
                    break
                }
            }
            
            //instantiate
            
           
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Hotel", bundle: nil)
//            var detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "HotelDetailVC") as! HotelDetailVC
//            let navigationVC = UINavigationController(rootViewController: detailViewController)
            
            let detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "HotelDetailVC") as! HotelDetailVC
            detailViewController.hotel = hotelSelected
            
//            detailViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailViewController, animated: true)
            
            
            
        }
        
    }
}

    
