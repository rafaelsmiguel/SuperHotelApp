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
        
        self.imgHotel.image = nil
        
        self.contentView.layer.cornerRadius = 30.0
        self.contentView.layer.masksToBounds = true
        
        let urlPhoto = foto.replacingOccurrences(of: "{size}", with: "b")
        
        guard let url = URL(string: urlPhoto) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imgHotel.image = image
                    }
                }
            }
        }
    }
    
}
