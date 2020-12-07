//
//  BookingDetailViewController.swift
//  Booking
//
//  Created by Elder Alcantara on 13/10/20.
//

import UIKit
import MapKit

class BookingDetailViewController: UIViewController {
    
    
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var periodOfStayLabel: UILabel!
    @IBOutlet weak var numberOfPeople: UILabel!
    @IBOutlet weak var valueByNight: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var controller: BookingListController = BookingListController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupBooking()
        
        
    }
    
    @IBAction func tappedVoltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupBooking() {
        
        if self.controller.booking != nil {
            
            self.hotelImageView.image = controller.bookingImage
            self.hotelNameLabel.text = self.controller.bookingName
            self.periodOfStayLabel.text = self.controller.bookingPeriod
            self.numberOfPeople.text = "\(self.controller.bookingPeople)"
            self.valueByNight.text = self.controller.bookingValueByNight
            self.amount.text = self.controller.bookingAmount
            self.address.text = self.controller.bookingAddress
                
            setupHotelLocation()
            
        }
        
        
        
    }
    
    
    func setupHotelLocation() {

        let annotation = MKPointAnnotation()

        let lat: Float = controller.bookingLatitude
        let lon: Float = controller.bookingLongitude
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        annotation.title = controller.bookingName
        mapView.addAnnotation(annotation)

        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.setRegion(region, animated: true)

    }
    
    
    
}
