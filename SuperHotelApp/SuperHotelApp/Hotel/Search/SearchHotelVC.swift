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
    @IBOutlet weak var viewResult: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var constraintMapSize: NSLayoutConstraint!
    
    var destinationId: String = ""
    var listHotel: [HotelElement] = []
    var hotelSelected: HotelElement = HotelElement()
    var searchController = SearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        
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
            
            constraintMapSize.isActive = false
            resultLabel.text = searchController.getQuantitySearchHotel()
            
           
        } else {
            self.mapView.removeAnnotations(self.mapView.annotations)
            constraintMapSize.isActive = true
            self.showToast(message: searchController.getMessageNotFoundHotel(),showTop: true)
            return
        }
    }
    
    func loadLocations() {
        
        searchController.loadLocations(city: searchTextField.text)
        
        self.searchController.getListSearch { (success) in
            if success {
                self.mapView.delegate = self
                self.setPins()
            }
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        
        fecharTeclado(searchTextField)
        
        if searchTextField.text?.count == 0 {
            self.mapView.removeAnnotations(self.mapView.annotations)
            constraintMapSize.isActive = true
            self.showToast(message: searchController.getMessageNeedWrite(),showTop: true)
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
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Hotel", bundle: nil)
        
            let hotelDetailViewController = storyboard.instantiateViewController(withIdentifier: "HotelDetailVC") as! HotelDetailVC
            hotelDetailViewController.hotelDetailController = HotelDetailController(hotel: searchController.hotel)
            self.navigationController?.pushViewController(hotelDetailViewController, animated: true)
        }
    }
}


