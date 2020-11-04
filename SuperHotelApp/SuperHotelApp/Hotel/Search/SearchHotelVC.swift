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
    
    var searchController = SearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
        mapView.delegate = self
        resultLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavBar()
    }
 
    func setupNavBar() {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = searchController.setupNavBar()
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
        
        if searchController.arrayCount > 0 {
        
        for i in 0...searchController.arrayCount - 1 {
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(searchController.getLatitude(index: i)), longitude: CLLocationDegrees(searchController.getLongitude(index: i)))
            
            annotation.title = searchController.getName(index: i)
            
            mapView.addAnnotation(annotation)
            
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
            mapView.setRegion(region, animated: true)
        }
            
        resultLabel.isHidden = false
        resultLabel.text = "\(searchController.arrayCount) Hotéis encontrados!"
        
//        listHotel = MockHotel().listHotel(location: searchTextField.text ?? "")
        
//        if !listHotel.isEmpty {
//
//            for item in listHotel {
//
//                let annotation = MKPointAnnotation()
//
//                guard let lat = Float(item.latitude ?? "") else {
//                    return
//                }
//
//                guard let long = Float(item.longitude ?? "") else {
//                    return
//                }
//
//                annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
//                annotation.title = item.name
//                mapView.addAnnotation(annotation)
//
//
//            }
            
//            resultLabel.isHidden = false
//            resultLabel.text = "\(listHotel.count) Hotéis encontrados!"
            
        } else {
            self.showToast(message: "Não encontramos hotéis para a cidade informada, tente novamente em outra cidade.",showTop: true)
            return
        }
    }
    
    func loadLocations() {
        searchController.loadLocations(city: searchTextField.text)
        setPins()
    }

    @IBAction func refresh(_ sender: Any) {
        
        fecharTeclado(searchTextField)
        
        if searchTextField.text?.count == 0 {
            self.showToast(message: "Para buscar um hotel é necessário preencher a cidade de destino.",showTop: true)
            return
        }
        
        loadLocations()
    }
    
    @IBAction func fecharTeclado(_ sender: UITextField) {
        
        searchTextField.resignFirstResponder()
    }
}

extension SearchHotelVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let annotation = view.annotation {
            
            for i in 0...searchController.arrayCount - 1 {
                if let annotationTitle = annotation.title {
                  let selected = searchController.hotelSelected(annotation: annotationTitle ?? "", index: i)
                
                    if selected {
                        break
                    }
                }
            }
            
            
//            for itemHotel in listHotel {
//                if itemHotel.name == annotation.title {
//                    hotelSelected = itemHotel
//                    break
//                }
//            }
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Hotel", bundle: nil)
//            var detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "HotelDetailVC") as! HotelDetailVC
//            let navigationVC = UINavigationController(rootViewController: detailViewController)
            
            let hotelDetailViewController = storyboard.instantiateViewController(withIdentifier: "HotelDetailVC") as! HotelDetailVC
            hotelDetailViewController.hotelDetailViewModel = HotelDetailViewModel(hotel: searchController.hotel)
            
//            detailViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(hotelDetailViewController, animated: true)
            
            
            
        }
        
    }
}

    
