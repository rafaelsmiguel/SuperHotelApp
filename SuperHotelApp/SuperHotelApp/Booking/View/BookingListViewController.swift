//
//  BookingListViewController.swift
//  Booking
//
//  Created by Elder Alcantara on 12/10/20.
//

import UIKit

class BookingListViewController: BaseViewController {
    
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var buscarHotelButton: UIView!
    @IBOutlet weak var bookingCollectionView: UICollectionView!
    
    var viewModel: BookingListViewModel = BookingListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookingCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        self.bookingCollectionView.register(UINib(nibName: "BookingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookingCollectionViewCell")
        self.bookingCollectionView.delegate = self
        
        self.viewModel = BookingListViewModel()
        
    }
    
    
    @IBAction func searchHotel(_ sender: Any) {
        
        if let viewControllers = self.tabBarController?.viewControllers {
            for (index, viewController) in viewControllers.enumerated() where viewController is SearchHotelVC {
                self.tabBarController?.selectedIndex = index
            }
        }
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = self.viewModel.navigationBarTitle
        
        //chamar loading
        self.showLoading()
        
        
        self.viewModel.getListBookingUserDefault (completion: { (success) in
            
            self.hiddenLoading()
            
            if success {
                
                self.bookingCollectionView.isHidden = false
                self.emptyStateView.isHidden = true
                self.bookingCollectionView.delegate = self
                self.bookingCollectionView.dataSource = self
                self.bookingCollectionView.reloadData()
                
                
            } else {
                
                self.bookingCollectionView.isHidden = true
                self.emptyStateView.isHidden = false
                
            }
            
        })
        
    }
    
    
}


extension BookingListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 300)
    }
}

extension BookingListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel.numberOfBookings
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: BookingCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingCollectionViewCell", for: indexPath) as? BookingCollectionViewCell
        
        cell?.delegate = self
        cell?.viewModel.booking = self.viewModel.aBooking?[indexPath.row]
        cell?.setupCell()
        
        
        return cell ?? UICollectionViewCell()
        
        
    }
}


extension BookingListViewController: actionCollectionViewCellDelegate {
    
    func tappedBooking(sender: Any?) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
        let bookingViewController = storyBoard.instantiateViewController(withIdentifier: "BookingDetailViewController") as! BookingDetailViewController
        
        bookingViewController.modalPresentationStyle = .fullScreen
        bookingViewController.viewModel.booking = sender as? BookingElement
        
        self.navigationController?.pushViewController(bookingViewController, animated: true)
        
    }
    
    
}


