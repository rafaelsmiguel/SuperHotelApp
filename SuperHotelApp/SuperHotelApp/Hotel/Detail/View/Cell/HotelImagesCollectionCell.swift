//
//  HotelImagesCollectionCell.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 03/11/20.
//

import UIKit

class HotelImagesCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgHotel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(foto:String) {
        imgHotel.image = UIImage(named: foto)
    }

}
