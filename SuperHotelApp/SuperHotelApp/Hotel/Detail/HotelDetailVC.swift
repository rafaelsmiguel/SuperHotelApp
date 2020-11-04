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
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var stackViewStars: UIStackView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var nightsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var bookingButton: SHButton_FilledGreen!
    
    var hotelDetailController: HotelDetailController?
    
    var fotos: [String] = ["hotel1.jpg","hotel2.jpg","hotel3.jpg","hotel4.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHotel()
        
        self.collectionView.register(UINib(nibName: "HotelImagesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HotelImagesCollectionCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavBar()
    }
    
    func setupNavBar() {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = hotelDetailController?.setupNavBar()
    }
    
    func setupHotel() {
        
        self.hotelNameLabel.text = hotelDetailController?.hotelName
        self.valueLabel.text = hotelDetailController?.valueByNight
        self.addressLabel.text = hotelDetailController?.address
        //self.imageViewHotel.image = UIImage(named: hotelDetailController?.image ?? "")
        
        setupHotelLocation()
    }
    
    func setupHotelLocation() {
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(hotelDetailController?.getLatitude() ?? 0), longitude: CLLocationDegrees(hotelDetailController?.getLongitude() ?? 0))
        annotation.title = hotelDetailController?.hotelName
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func tapBookingButton(_ sender: SHButton_FilledGreen) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Hotel", bundle: nil)
        let bookingViewController = storyBoard.instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
        bookingViewController.modalPresentationStyle = .fullScreen
        bookingViewController.navigationController?.navigationBar.isHidden = false
        bookingViewController.bookingController = BookingController(hotel: hotelDetailController?.getHotelDetail())
        self.present(bookingViewController, animated: true, completion: nil)
    }

}

extension HotelDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: HotelImagesCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelImagesCollectionCell", for: indexPath) as? HotelImagesCollectionCell
        
        cell?.setup(foto: fotos[indexPath.item])
        
        return cell ?? UICollectionViewCell()
    }
    
    
}
