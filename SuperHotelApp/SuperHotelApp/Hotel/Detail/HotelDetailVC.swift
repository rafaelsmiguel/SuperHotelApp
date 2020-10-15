//
//  HotelDetailVC.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit
import MapKit

class HotelDetailVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageViewHotel: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    
    @IBOutlet weak var stackViewStars: UIStackView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var nightsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var bookingButton: SHButton_FilledGreen!
    
    var hotel: HotelModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setupHotel()
        
        setupHotel()

    }
    
    func setupHotel() {
        
        if let hotel = self.hotel {
            self.hotelNameLabel.text = hotel.name
            
            self.valueLabel.text = Helper.transformToCurrency(value: hotel.valueByNight ?? 0)
            self.addressLabel.text = hotel.address
            self.imageViewHotel.image = UIImage(named: hotel.image ?? "")
            
            setupHotelLocation(hotel: hotel)
        }
    }
    
    func setupHotelLocation(hotel: HotelModel) {
        
        let annotation = MKPointAnnotation()
        
        guard let lat = Float(hotel.latitude ?? "") else {
            return
        }
        
        guard let long = Float(hotel.longitude ?? "") else {
            return
        }
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        annotation.title = hotel.name
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func tapBookingButton(_ sender: SHButton_FilledGreen) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Hotel", bundle: nil)
        let bookingViewController = storyBoard.instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
        bookingViewController.modalPresentationStyle = .fullScreen
        bookingViewController.navigationController?.navigationBar.isHidden = false
        bookingViewController.hotel = self.hotel
        self.present(bookingViewController, animated: true, completion: nil)
        
        
    }

}
