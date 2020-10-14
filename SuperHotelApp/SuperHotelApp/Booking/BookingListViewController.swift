//
//  BookingListViewController.swift
//  Booking
//
//  Created by Elder Alcantara on 12/10/20.
//

import UIKit

class BookingListViewController: UIViewController {
    
    @IBOutlet weak var bookingCollectionView: UICollectionView!
    
    var arrayBookings:[BookingModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavBar()
        
        
        
        self.bookingCollectionView.delegate = self
        self.bookingCollectionView.dataSource = self
        
        self.bookingCollectionView.register(UINib(nibName: "BookingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookingCollectionViewCell")
        
        
        self.arrayBookings = [
            BookingModel(hotelImagem: "hotel1.jpg", hotelName: "Hotel Marriot", periodOfStay: "De 25 de maio até 27 de maio", numberOfPeople: "3", valueByNight: "$199", amount: "$597", address: "Avenida Raimundo 287 - Pirituba - São Paulo - SP", latitude: "-23.560640", longitude: "-46.650570"),
            BookingModel(hotelImagem: "hotel2.jpg", hotelName: "Hotel Lorem", periodOfStay: "De 25 de maio até 27 de maio", numberOfPeople: "3", valueByNight: "$199", amount: "$597", address: "Avenida Raimundo 287 - Pirituba - São Paulo - SP", latitude: "-23.560640", longitude: "-46.650570"),
            BookingModel(hotelImagem: "hotel3.jpg", hotelName: "Hotel Marriot", periodOfStay: "De 25 de maio até 27 de maio", numberOfPeople: "3", valueByNight: "$199", amount: "$597", address: "Avenida Raimundo 287 - Pirituba - São Paulo - SP", latitude: "-23.560640", longitude: "-46.650570"),
            BookingModel(hotelImagem: "hotel4.jpg", hotelName: "Hotel Ipsum", periodOfStay: "De 25 de maio até 27 de maio", numberOfPeople: "3", valueByNight: "$199", amount: "$597", address: "Avenida Raimundo 287 - Pirituba - São Paulo - SP", latitude: "-23.560640", longitude: "-46.650570"),
            BookingModel(hotelImagem: "hotel5.jpg", hotelName: "Hotel Dulorem", periodOfStay: "De 25 de maio até 27 de maio", numberOfPeople: "3", valueByNight: "$199", amount: "$597", address: "Avenida Raimundo 287 - Pirituba - São Paulo - SP", latitude: "-23.560640", longitude: "-46.650570"),]
        
        
    }
    
    
    func setupNavBar() {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = "Reservas"
        
    }
    
    
}


extension BookingListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arrayBookings.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: BookingCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingCollectionViewCell", for: indexPath) as? BookingCollectionViewCell
        
        cell?.delegate = self
        cell?.booking = self.arrayBookings[indexPath.row]
        cell?.setupCell()
        
        
        return cell ?? UICollectionViewCell()
        
        
    }
    
    
}


extension BookingListViewController: actionCollectionViewCellDelegate {
    
    func cliqueReservation(sender: Any?) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
        let bookingViewController = storyBoard.instantiateViewController(withIdentifier: "BookingDetailViewController") as! BookingDetailViewController
        
        
        bookingViewController.modalPresentationStyle = .fullScreen
        //      bookingViewController.navigationController?.navigationBar.isHidden = false
        bookingViewController.booking = sender as! BookingModel
        self.present(bookingViewController, animated: true, completion: nil)
        
    }
    
    
}


