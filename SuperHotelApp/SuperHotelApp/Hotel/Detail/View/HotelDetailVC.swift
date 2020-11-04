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
    
    var hotelDetailViewModel: HotelDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHotel()
        
        self.collectionView.register(UINib(nibName: "HotelImagesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HotelImagesCollectionCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupHotel() {
        
        self.hotelNameLabel.text = hotelDetailViewModel?.hotelName
        self.valueLabel.text = hotelDetailViewModel?.valueByNight
        self.addressLabel.text = hotelDetailViewModel?.address
        //self.imageViewHotel.image = UIImage(named: hotelDetailViewModel?.image ?? "")
        
        setupHotelLocation()
    }
    
    func setupHotelLocation() {
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(hotelDetailViewModel?.getLatitude() ?? 0), longitude: CLLocationDegrees(hotelDetailViewModel?.getLongitude() ?? 0))
        annotation.title = hotelDetailViewModel?.hotelName
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func tapBookingButton(_ sender: SHButton_FilledGreen) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Hotel", bundle: nil)
        let bookingViewController = storyBoard.instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
        bookingViewController.modalPresentationStyle = .fullScreen
        bookingViewController.navigationController?.navigationBar.isHidden = false
        bookingViewController.bookingController = BookingController(hotel: hotelDetailViewModel?.getHotelDetail())
        self.present(bookingViewController, animated: true, completion: nil)
    }

}

extension HotelDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hotelDetailViewModel?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: HotelImagesCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelImagesCollectionCell", for: indexPath) as? HotelImagesCollectionCell
        
        cell?.setup(foto: hotelDetailViewModel?.images?[indexPath.item] ?? "")
        
        return cell ?? UICollectionViewCell()
    }
    
    
}
