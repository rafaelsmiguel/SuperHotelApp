//
//  BookingListViewController.swift
//  Booking
//
//  Created by Elder Alcantara on 12/10/20.
//

import UIKit

class BookingListViewController: UIViewController {
    
    @IBOutlet weak var bookingCollectionView: UICollectionView!
    
    var controller: BookingListController = BookingListController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.controller = BookingListController()
        
        self.controller.getListBooking(completion: { (success) in
            
            if success {
                self.bookingCollectionView.delegate = self
                self.bookingCollectionView.dataSource = self
                self.bookingCollectionView.register(UINib(nibName: "BookingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookingCollectionViewCell")
            } else {
                print("ERRO getListBooking >> BookingListViewController")
            }
            
        })
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = controller.navigationBarTitle
    }
    
    
}


extension BookingListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.controller.numberOfBookings
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: BookingCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingCollectionViewCell", for: indexPath) as? BookingCollectionViewCell
        
        cell?.delegate = self
        cell?.controller.booking = self.controller.arrayBookings?.bookings[indexPath.row]
        cell?.setupCell()
        
        
        return cell ?? UICollectionViewCell()
        
        
    }
    
    
}


extension BookingListViewController: actionCollectionViewCellDelegate {
    
    func tappedBooking(sender: Any?) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
        let bookingViewController = storyBoard.instantiateViewController(withIdentifier: "BookingDetailViewController") as! BookingDetailViewController
        
        bookingViewController.modalPresentationStyle = .fullScreen
        bookingViewController.controller.booking = sender as? BookingElement
        self.present(bookingViewController, animated: true, completion: nil)
        
    }
    
    
}


