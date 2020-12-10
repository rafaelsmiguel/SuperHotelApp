//
//  BookingListViewController.swift
//  Booking
//
//  Created by Elder Alcantara on 12/10/20.
//

import UIKit

class BookingListViewController: BaseViewController {
    
    @IBOutlet weak var bookingCollectionView: UICollectionView!
    
    var controller: BookingListController = BookingListController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.checkBooking()
        
        // Do any additional setup after loading the view.
        
        //        var aBooking: [BookingElement] = []
        //        let defaults = UserDefaults.standard
        //
        //        if let reservas = defaults.object(forKey: "reservas") as? Data {
        //          let decoder = JSONDecoder()
        //          if let loadBooking = try? decoder.decode([BookingElement].self, from: reservas) {
        //            aBooking = loadBooking
        //          }
        //        }
        
        self.controller = BookingListController()
        
        //        self.controller.getListBooking(completion: { (success) in
        //
        //            if success {
        //                self.bookingCollectionView.delegate = self
        //                self.bookingCollectionView.dataSource = self
        //                self.bookingCollectionView.register(UINib(nibName: "BookingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookingCollectionViewCell")
        //            } else {
        //                print("ERRO getListBooking >> BookingListViewController")
        //            }
        //
        //        })
        
        
    }
    
    func checkBooking() {
        
        let defaults = UserDefaults.standard
        if let _ = defaults.object(forKey: "reservas") as? Data {
            
            self.showLoading()
            
        } else {
            
            
            
            let noBookingAlert = UIAlertController(title: "Ops...", message: "Você não possui reserva registrada! Toque na opção BUSCAR do menu e registre sua reserva.", preferredStyle: UIAlertController.Style.alert)
            
            noBookingAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.reloadInputViews()
            }))
            
            self.present(noBookingAlert, animated: true)
            
        }
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = controller.navigationBarTitle
        
        self.bookingCollectionView.register(UINib(nibName: "BookingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookingCollectionViewCell")
        
        self.controller.getListBookingUserDefault (completion: { (success) in
            
            if success {
                self.bookingCollectionView.delegate = self
                self.bookingCollectionView.dataSource = self
                self.bookingCollectionView.reloadData()
                self.hiddenLoading()
                
            } else {
                print("ERRO getListBooking >> BookingListViewController")
            }
            
        })
        
    }
    
    
}


extension BookingListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.controller.numberOfBookings
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: BookingCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingCollectionViewCell", for: indexPath) as? BookingCollectionViewCell
        
        cell?.delegate = self
        cell?.controller.booking = self.controller.aBooking?[indexPath.row]
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


