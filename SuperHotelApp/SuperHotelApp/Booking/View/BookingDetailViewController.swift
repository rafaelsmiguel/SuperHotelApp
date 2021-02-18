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
    @IBOutlet weak var stackViewStar: UIStackView!
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
        
        self.setupNavigationBar()
        self.setupBooking()
        
    }
    
    
    func setupNavigationBar(){
        
        self.navigationItem.title = "Detalhe Reserva"
        self.navigationController?.navigationBar.tintColor = Cores.verde
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
    
    func setupBooking() {
        
        if self.controller.booking != nil {
            
            //self.hotelImageView.image = self.controller.bookingImage
            self.hotelNameLabel.text = self.controller.bookingName
            self.periodOfStayLabel.text = self.controller.bookingPeriod
            self.numberOfPeople.text = "\(self.controller.bookingPeople)"
            self.valueByNight.text = self.controller.bookingValueByNight
            self.amount.text = self.controller.bookingAmount
            self.address.text = self.controller.bookingAddress
            
            self.setupStar()
            self.setupHotelLocation()
            setImage (from: self.controller.bookingImage)

        }
        
    }
    
    
    
    func setupStar() {
        
        for viewStars in stackViewStar.subviews {
            viewStars.removeFromSuperview()
        }
        
        stackViewStar.distribution = .fillEqually
        stackViewStar.alignment = .center
        stackViewStar.translatesAutoresizingMaskIntoConstraints = false
        stackViewStar.spacing = 3
        
        if let stars = self.controller.booking?.starRating {
            for _ in 1...stars {
                let star = UIImageView()
                star.image = UIImage(systemName: "star.fill")
                star.image?.withRenderingMode(.alwaysTemplate)
                star.tintColor = Cores.amarelo
                
                stackViewStar.addArrangedSubview(star)
            }
        }
    }
    
    
    
    func setupHotelLocation() {
        
        let annotation = MKPointAnnotation()
        
        let lat: Double = self.controller.bookingLatitude
        let lon: Double = self.controller.bookingLongitude
        
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        annotation.title = controller.bookingName
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    
    
    func setImageToImageView() {
        self.controller.fetchImage(from: self.controller.bookingImage) { (imageData) in
            if let data = imageData {
                DispatchQueue.main.async {
                    self.hotelImageView.image = UIImage(data: data)
                }
            } else {
                    // show as an alert if you want to
                print("Error loading image");
            }
        }
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.hotelImageView.image = image
            }
        }
    }
    
    
    
}
