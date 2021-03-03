//
//  HotelImagesCollectionCell.swift
//  SuperHotelApp
//
//  Created by Rafael Miguel on 03/11/20.
//

import UIKit
import Kingfisher

class HotelImagesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imgHotel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imgHotel.kf.cancelDownloadTask()
        self.imgHotel.image = nil
    }
    
    func setup(foto:String) {
        
        self.contentView.layer.cornerRadius = 30.0
        self.contentView.layer.masksToBounds = true
        
        let urlPhoto = foto.replacingOccurrences(of: "{size}", with: "b")
        
        guard let url = URL(string: urlPhoto) else {
            return
        }
        
        imgHotel.kf.indicatorType = .activity
        imgHotel.kf.setImage(with: url, options: [.transition(.fade(0.2))])
        
    }
    
}
