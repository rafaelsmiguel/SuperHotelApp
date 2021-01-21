//
//  SearchHotelVC.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit
import MapKit

class SearchHotelVC: BaseViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchTextField: SHTextField!
    @IBOutlet weak var viewResult: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var constraintMapSize: NSLayoutConstraint!
    var annotationInfo: MKAnnotation?
    
    var destinationId: String = ""
    var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavBar()
    }
    
    func setupNavBar() {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = searchViewModel.setupNavBar()
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
        
        if searchViewModel.arrayCount > 0 {
            
            for i in 0...searchViewModel.arrayCount - 1 {
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(searchViewModel.getLatitude(index: i)), longitude: CLLocationDegrees(searchViewModel.getLongitude(index: i)))
                
                annotation.title = searchViewModel.getName(index: i)
                
                mapView.addAnnotation(annotation)
                
                DispatchQueue.main.async {
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 20000, longitudinalMeters: 20000)
                    self.mapView.setRegion(region, animated: true)
                }
            }
            
            DispatchQueue.main.async {
                self.constraintMapSize.isActive = false
                self.resultLabel.text = self.searchViewModel.getQuantitySearchHotel()
            }
           
        } else {
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.constraintMapSize.isActive = true
            self.showToast(message: searchViewModel.getMessageNotFoundHotel(),showTop: true)
            return
        }
    }
    
    
    func searchTerms() {
        searchViewModel.loadLocations(city: searchTextField.text)
        
        self.searchViewModel.getListSearch { (success) in
            if success {
                self.loadLocations()
            } else {
                DispatchQueue.main.async {
//                    self.constraintMapSize.isActive = true
//                    self.mapView.removeAnnotations(self.mapView.annotations)
//                    self.showToast(message: self.searchViewModel.getMessageNotFoundHotel(),showTop: true)
                }
            }
        }
    }
    
    func loadLocations() {
        
        self.searchViewModel.getListHotel { (success) in
            if success {
                self.mapView.delegate = self
                self.hiddenLoading()
                self.setPins()
            } else {
                DispatchQueue.main.async {
                    self.constraintMapSize.isActive = true
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    self.hiddenLoading()
                    self.showToast(message: self.searchViewModel.getMessageNotFoundHotel(),showTop: true)
                    
                }
            }
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        
        fecharTeclado(searchTextField)
        
        self.showLoading()
        
        if searchTextField.text?.count == 0 {
            self.mapView.removeAnnotations(self.mapView.annotations)
            constraintMapSize.isActive = true
            self.showToast(message: searchViewModel.getMessageNeedWrite(),showTop: true)
            return
        }
        
        searchTerms()
    }
    
    @IBAction func fecharTeclado(_ sender: UITextField) {
        
        searchTextField.resignFirstResponder()
    }
}

extension SearchHotelVC: MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//
//        if let annotation = view.annotation {
//
//            for i in 0...searchViewModel.arrayCount - 1 {
//                if let annotationTitle = annotation.title {
//                    let selected = searchViewModel.hotelSelected(annotation: annotationTitle ?? "", index: i)
//
//                    if selected {
//                        break
//                    }
//                }
//            }
//
//            let storyboard: UIStoryboard = UIStoryboard(name: "Hotel", bundle: nil)
//
//            let hotelDetailViewController = storyboard.instantiateViewController(withIdentifier: "HotelDetailVC") as! HotelDetailVC
//            hotelDetailViewController.hotelDetailViewModel = HotelDetailViewModel(hotel: self.searchViewModel.resultHotel)
//            self.navigationController?.pushViewController(hotelDetailViewController, animated: true)
//        }
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let annotation = annotation as? Agencia else {return nil}
        
        let identifier = "marker"
        let view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x:-5, y: 5)
            //view.rightCalloutAccessoryView = UIButton(type: .contactAdd)
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = "teste"
            
            view.detailCalloutAccessoryView = detailLabel
            
            let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            button.setBackgroundImage(UIImage(named: "image"), for: .normal)
            view.rightCalloutAccessoryView = button
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let annotation = view.annotation {
            self.annotationInfo = annotation
            
            self.performSegue(withIdentifier: "HotelDetailVC", sender: annotation)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc:HotelDetailVC? = segue.destination as? HotelDetailVC
//        vc?.annotationInfo = self.annotationInfo
        
//        if sender is MKAnnotation {
//
//            vc?.setup(annotation: sender as? MKAnnotation)
//        }
       
        
       
    }
}


