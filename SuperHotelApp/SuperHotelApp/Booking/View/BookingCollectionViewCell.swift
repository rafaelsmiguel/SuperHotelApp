//
//  BookingCollectionViewCell.swift
//  SuperHotelApp
//
//  Created by Elder Alcantara on 14/10/20.
//

import UIKit

protocol actionCollectionViewCellDelegate {
    
    func tappedBooking(sender: Any?)
    
}

class BookingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var periodOfStayLabel: UILabel!
    
    var controller: BookingListController = BookingListController()
    var delegate: actionCollectionViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.hotelImageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapped(sender: )))
        self.hotelImageView.addGestureRecognizer(tap)
        
        
    }
    
    
    
    @objc func didTapped(sender: UITapGestureRecognizer){
        
        delegate?.tappedBooking(sender: controller.booking)
        
    }
    
    
    
    func setupCell(){
        
        self.hotelImageView.image = controller.bookingImage
        self.hotelNameLabel.text = controller.bookingName
        self.periodOfStayLabel.text = controller.bookingPeriod
        
    }
    
}
