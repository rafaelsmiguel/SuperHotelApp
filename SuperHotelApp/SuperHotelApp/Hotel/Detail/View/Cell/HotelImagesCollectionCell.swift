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
        
        let urlPhoto = foto.replacingOccurrences(of: "{size}", with: "w")
        
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
