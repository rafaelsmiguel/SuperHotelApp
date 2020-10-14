//
//  BookingCollectionViewCell.swift
//  SuperHotelApp
//
//  Created by Elder Alcantara on 14/10/20.
//

import UIKit

protocol actionCollectionViewCellDelegate {
    
    func cliqueReservation(sender: Any?)
    
}

class BookingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var periodOfStayLabel: UILabel!
    
    var delegate: actionCollectionViewCellDelegate?
    var booking: BookingModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.hotelImageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapped(sender: )))
        self.hotelImageView.addGestureRecognizer(tap)
        
        
    }
    
    
    
    @objc func didTapped(sender: UITapGestureRecognizer){
        
        delegate?.cliqueReservation(sender: booking)
        
    }
    
    
    
    func setupCell(){
        
        self.hotelImageView.image = UIImage(named: booking?.hotelImagem ?? "")
        self.hotelNameLabel.text = booking?.hotelName
        self.periodOfStayLabel.text = booking?.periodOfStay
        
    }
    
}
