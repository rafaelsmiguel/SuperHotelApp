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
    
    var booking: Booking?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupBooking()
        
        
    }
    
    @IBAction func tappedVoltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupBooking() {
        
        if let booking = self.booking {
            
            self.hotelImageView.image = UIImage(named: booking.hotelImagem ?? "")
            self.hotelNameLabel.text = booking.hotelName
            self.periodOfStayLabel.text = booking.periodOfStay
            self.numberOfPeople.text = booking.numberOfPeople
            self.valueByNight.text = booking.valueByNight
            self.amount.text = booking.amount
            self.address.text = booking.address
            
            setupHotelLocation(booking: booking)
            
            
        }
        
        
        
    }
    
    
    func setupHotelLocation(booking: Booking) {
        
        let annotation = MKPointAnnotation()
        
        guard let lat = Float(booking.latitude ?? "") else {
            return
        }
        
        guard let lon = Float(booking.longitude ?? "") else {
            return
        }
        
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        annotation.title = booking.hotelName
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.setRegion(region, animated: true)
        
        
    }
    
    
    
}
