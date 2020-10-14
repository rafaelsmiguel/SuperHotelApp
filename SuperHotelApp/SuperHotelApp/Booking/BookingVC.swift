//
//  BookingVC.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit

class BookingVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var hotelLabel: UILabel!
    @IBOutlet weak var stackViewStar: UIStackView!
    @IBOutlet weak var stackViewFields: UIStackView!
    @IBOutlet weak var checkinTextField: SHTextField!
    @IBOutlet weak var checkoutTextField: SHTextField!
    @IBOutlet weak var quantityTextFields: SHTextField!
    @IBOutlet weak var confirmButton: SHButton_FilledGreen!
    
    var hotel: HotelModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapConfirmButton(_ sender: SHButton_FilledGreen) {
        
        if checkinTextField.text == "" {
            showToast(message: "Check-in deve ser preenchido.")
            return
        }
        
        if checkoutTextField.text == "" {
            showToast(message: "Check-out deve ser preenchido.")
            return
        }
        
        if quantityTextFields.text == "" {
            showToast(message: "Quantidade de hóspedes deve ser preenchido.")
            return
        }
        
        let refreshAlert = UIAlertController(title: "Reserva Efetuada", message: "Sua reserva foi efetuada com sucesso!", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Fechar", style: .default, handler: { (action: UIAlertAction!) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(refreshAlert, animated: true)
        
    }

}
