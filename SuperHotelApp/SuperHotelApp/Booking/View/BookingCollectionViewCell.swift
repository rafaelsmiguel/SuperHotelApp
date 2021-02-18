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
        
        //self.hotelImageView.image = controller.bookingImage
        setImage (from: self.controller.bookingImage)
        self.hotelNameLabel.text = controller.bookingName
        self.periodOfStayLabel.text = controller.bookingPeriod
        
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
