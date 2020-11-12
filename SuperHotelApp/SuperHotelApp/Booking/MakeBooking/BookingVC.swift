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
    @IBOutlet weak var quantityTextFields: SHTextField!
    @IBOutlet weak var confirmButton: SHButton_FilledGreen!
    @IBOutlet weak var checkinButton: SHButton_FilledWhite!
    @IBOutlet weak var checkoutButton: SHButton_FilledWhite!
    @IBOutlet weak var viewToolbar: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dataSelecionada: Date? = nil
    var dataCheckinValue = ""
    var dataCheckoutValue = ""
    
    var bookingController: BookingController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavBar()
    }
    
    func setupNavBar() {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = bookingController?.setupNavBar()
    }
    
    func setupView() {
        
        datePicker.isHidden = true
        viewToolbar.isHidden = true
    
        self.quantityTextFields.delegate = self
        self.quantityTextFields.keyboardType = .numberPad
        
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.datePickerMode = .date
        
//        self.hotelLabel.text = bookingController?.hotelName
    }
    
    @IBAction func tapCheckin(_ sender: UIButton) {
        
        fecharTeclado(quantityTextFields)
        datePicker.isHidden = false
        viewToolbar.isHidden = false
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor.gray
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let selecionarButton = UIBarButtonItem(title: "Selecionar", style: .plain, target: self, action: #selector(BookingVC.selecionarDataCheckin))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fecharButton = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(BookingVC.fecharData))
        toolBar.setItems([fecharButton, spaceButton, selecionarButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = viewToolbar.bounds
        viewToolbar.addSubview(toolBar)
    }
    
    @IBAction func tapCheckout(_ sender: UIButton) {
        
        fecharTeclado(quantityTextFields)
        datePicker.isHidden = false
        viewToolbar.isHidden = false
        
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor.gray
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let selecionarButton = UIBarButtonItem(title: "Selecionar", style: .plain, target: self, action: #selector(BookingVC.selecionarDataCheckout))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fecharButton = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(BookingVC.fecharData))
        toolBar.setItems([fecharButton, spaceButton, selecionarButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = viewToolbar.bounds
        viewToolbar.addSubview(toolBar)
    }
    
    
    @objc func selecionarDataCheckin() {
        
        dataSelecionada = datePicker.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        datePicker.isHidden = true
        viewToolbar.isHidden = true
        
        if let data = dataSelecionada
        {
            checkinButton.setTitle("\(dateFormatter.string(from: data))", for: .normal)
            dataCheckinValue = "\(dateFormatter.string(from: data))"
        }
    }
    
    @objc func selecionarDataCheckout() {
        
        dataSelecionada = datePicker.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        datePicker.isHidden = true
        viewToolbar.isHidden = true
        
        if let data = dataSelecionada
        {
            checkoutButton.setTitle("\(dateFormatter.string(from: data))", for: .normal)
            dataCheckoutValue = "\(dateFormatter.string(from: data))"
        }
    }
    
    @objc func fecharData()
    {
        datePicker.isHidden = true
        viewToolbar.isHidden = true
    }
    
    @IBAction func fecharTeclado(_ sender: UITextField) {
        
        quantityTextFields.resignFirstResponder()
    }
    
    @IBAction func tapConfirmButton(_ sender: SHButton_FilledGreen) {
        
        fecharTeclado(quantityTextFields)
        fecharData()
        
        if dataCheckinValue == "" {
            showToast(message: "Check-in deve ser preenchido.")
            return
        }

        if dataCheckoutValue == "" {
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

extension BookingVC: UITextFieldDelegate {
   

}
