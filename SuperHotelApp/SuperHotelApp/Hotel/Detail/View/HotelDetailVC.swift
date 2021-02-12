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
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var nightsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var bookingButton: SHButton_FilledGreen!
    
    var hotelDetailViewModel: HotelDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.isHidden = true
        
        setupHotel()
        
        self.collectionView.register(UINib(nibName: "HotelImagesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HotelImagesCollectionCell")
        
        
    }
    
    func setupStar() {
        
        for viewStars in stackViewStars.subviews
        {
            viewStars.removeFromSuperview()
        }
        
        stackViewStars.distribution = .fillEqually
        stackViewStars.alignment = .center
        stackViewStars.translatesAutoresizingMaskIntoConstraints = false
        stackViewStars.spacing = 3
        
        if let stars = self.hotelDetailViewModel?.getStars() {
            for _ in 1...stars {
                let star = UIImageView()
                star.image = UIImage(systemName: "star.fill")
                star.image?.withRenderingMode(.alwaysTemplate)
                star.tintColor = Cores.amarelo
                
                stackViewStars.addArrangedSubview(star)
            }
        }
    }
    
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setupHotel() {

        self.mainView.isHidden = false
        self.hotelNameLabel.text = self.hotelDetailViewModel?.hotelName
        self.valueLabel.text = self.hotelDetailViewModel?.valueByNightFormat
        self.addressLabel.text = self.hotelDetailViewModel?.address
        self.setupStar()
        
        self.setupPhotos()
        self.setupHotelLocation()
        
    }
    
    func setupHotelLocation() {
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(hotelDetailViewModel?.getLatitude() ?? 0), longitude: CLLocationDegrees(hotelDetailViewModel?.getLongitude() ?? 0))
        annotation.title = hotelDetailViewModel?.hotelName
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.setRegion(region, animated: true)
    }
    
    func setupStars() {
        
    }
    
    func setupPhotos() {
        
        self.hotelDetailViewModel?.getHotelPhotos(completion: { (success) in
            if success {
                DispatchQueue.main.async {
                    self.collectionView.delegate = self
                    self.collectionView.dataSource = self
                }
            } else {
                DispatchQueue.main.async {
                    self.showToast(message: "Não foi possível carregar as imagens do hotel.",showTop: true)
                }
                
            }
        })
        
    }
    
    @IBAction func tapBookingButton(_ sender: SHButton_FilledGreen) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Hotel", bundle: nil)
        let bookingViewController = storyBoard.instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
        bookingViewController.bookingViewModel = BookingViewModel(hotel: HotelModel(destinationId: "", name: self.hotelDetailViewModel?.hotelName, latitude: self.hotelDetailViewModel?.getLatitude(), longitude: self.hotelDetailViewModel?.getLongitude(), valueByNight: self.hotelDetailViewModel?.valueByNight, address: self.hotelDetailViewModel?.address, images: self.hotelDetailViewModel?.mainPhotoURL ?? [],starRating: self.hotelDetailViewModel?.getStars()))
        
        self.navigationController?.pushViewController(bookingViewController, animated: true)
    }
    
}

extension HotelDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hotelDetailViewModel?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: HotelImagesCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelImagesCollectionCell", for: indexPath) as? HotelImagesCollectionCell
        
        cell?.setup(foto: hotelDetailViewModel?.images?[indexPath.item].baseUrl ?? "")
        
        return cell ?? UICollectionViewCell()
    }
    
    
}
