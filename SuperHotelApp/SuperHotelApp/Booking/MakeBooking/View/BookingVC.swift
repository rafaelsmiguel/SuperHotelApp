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
    @IBOutlet weak var adultsButton: SHButton_FilledWhite!
    @IBOutlet weak var viewToolbar: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerViewAdults: UIPickerView!
    
    var dataSelecionada: Date? = nil

    var bookingViewModel: BookingViewModel?
    
    var adults: [Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hotelLabel.text = self.bookingViewModel?.hotelName
        setupTextField()
        setupDatePicker()
        setupPickerView()
        
        self.title = "Reserva"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavBar()
    }
    
    func setupNavBar() {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = bookingViewModel?.setupNavBar()
    }
    
    func setupDatePicker() {
       
        setupVisibilityDatePicker(value: true)
        
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.datePickerMode = .date
    }
    
    func setupVisibilityDatePicker(value: Bool) {
        datePicker.isHidden = value
        viewToolbar.isHidden = value
    }
    
    func setupPickerView() {
       
        setupVisibilityPicker(value: true)
        
        self.pickerViewAdults.dataSource = self
        self.pickerViewAdults.delegate = self
        self.datePicker.datePickerMode = .date
        
        self.adults = self.bookingViewModel?.maxAdultsForRoom()
    }
    
    func setupVisibilityPicker(value: Bool) {
        pickerViewAdults.isHidden = value
        viewToolbar.isHidden = value

//        self.hotelLabel.text = bookingController?.hotelName
    }
    
    
    @IBAction func tapCheckin(_ sender: UIButton) {
        
        fecharTeclado(quantityTextFields)
        closePickerView()
        
        setupVisibilityDatePicker(value:false)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = .lightGray
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let selecionarButton = UIBarButtonItem(title: "Selecionar", style: .plain, target: self, action: #selector(BookingVC.selecionarDataCheckin))
        selecionarButton.tintColor = .white
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fecharButton = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(BookingVC.fecharData))
        fecharButton.tintColor = .white
        toolBar.setItems([fecharButton, spaceButton, selecionarButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = viewToolbar.bounds
        viewToolbar.addSubview(toolBar)
    }
    
    @IBAction func tapCheckout(_ sender: UIButton) {
        
        fecharTeclado(quantityTextFields)
        closePickerView()
        
        setupVisibilityDatePicker(value:false)
    
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = .lightGray
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let selecionarButton = UIBarButtonItem(title: "Selecionar", style: .plain, target: self, action: #selector(BookingVC.selecionarDataCheckout))
        selecionarButton.tintColor = .white
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fecharButton = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(BookingVC.fecharData))
        fecharButton.tintColor = .white
        toolBar.setItems([fecharButton, spaceButton, selecionarButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = viewToolbar.bounds
        viewToolbar.addSubview(toolBar)
    }
    
    @IBAction func tapAdults(_ sender: UIButton) {
        
        buildPickerView()
    }
    
    
    @objc func selecionarDataCheckin() {
        
//        var teste = self.bookingViewModel.maxAdultsForRoom()
        
        dataSelecionada = datePicker.date
        
        setupVisibilityDatePicker(value:true)
        
        if let data = dataSelecionada
        {
            checkinButton.setTitle(self.bookingViewModel?.formatDate(date: data), for: .normal)
            self.bookingViewModel?.setCheckin(checkIn: self.bookingViewModel?.formatDate(date: data) ?? "")
        }
    }
    
    @objc func selecionarDataCheckout() {
        
        dataSelecionada = datePicker.date
        
        setupVisibilityDatePicker(value:true)
        
        if let data = dataSelecionada
        {
            checkoutButton.setTitle(self.bookingViewModel?.formatDate(date: data), for: .normal)
            self.bookingViewModel?.setCheckout(checkOut: self.bookingViewModel?.formatDate(date: data) ?? "")
        }
    }
    
    @objc func fecharData()
    {
        setupVisibilityDatePicker(value:true)
    }
    
    @IBAction func fecharTeclado(_ sender: UITextField) {
        
        quantityTextFields.resignFirstResponder()
    }
    
    @IBAction func tapConfirmButton(_ sender: SHButton_FilledGreen) {
        
        fecharTeclado(quantityTextFields)
        fecharData()
        closePickerView()
        
        
        if self.bookingViewModel?.checkIn == nil {
            showToast(message: "Check-in deve ser preenchido.")
            return
        }
        
        if self.bookingViewModel?.checkOut == nil {
            showToast(message: "Check-out deve ser preenchido.")
            return
        }
        
        if self.bookingViewModel?.adults == nil || self.bookingViewModel?.adults == 0 {
            showToast(message: "Quantidade de hóspedes deve ser preenchido.")
            return
        }
        
        let refreshAlert = UIAlertController(title: "Reserva Efetuada", message: "Sua reserva foi efetuada com sucesso!", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Fechar", style: .default, handler: { (action: UIAlertAction!) in
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }))
        
        self.present(refreshAlert, animated: true)
        
    }

}

extension BookingVC: UITextFieldDelegate {
   
    func setupTextField() {
        
        quantityTextFields.isHidden = true
        self.quantityTextFields.delegate = self
        self.quantityTextFields.keyboardType = .numberPad
    }
}

extension BookingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func buildPickerView()
    {
        fecharTeclado(quantityTextFields)
        fecharData()
        
        setupVisibilityPicker(value: false)
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = .lightGray
        toolBar.sizeToFit()
        
        let selecionarButton = UIBarButtonItem(title: "Selecionar", style: .plain, target: self, action: #selector(BookingVC.selectValuePicker))
        selecionarButton.tintColor = .white
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fecharButton = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(BookingVC.closePickerView))
        fecharButton.tintColor = .white
       
        toolBar.setItems([fecharButton, spaceButton, selecionarButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = viewToolbar.bounds
        viewToolbar.addSubview(toolBar)
        
        pickerViewAdults.reloadAllComponents()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return adults?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if let adults = self.adults {
            return "\(adults[row])"
        }
        
        return ""
       
    }
    
    @objc func selectValuePicker() {
        
        if let adults = self.adults {
            let adult = adults[pickerViewAdults.selectedRow(inComponent: 0)]
            
            adultsButton.setTitle("\(adult)", for: .normal)
            
            self.bookingViewModel?.setAdults(adults: adult )

            setupVisibilityPicker(value: true)
        }
        
            
        
    }
    
    @objc func closePickerView() {
        
        setupVisibilityPicker(value: true)
        
    }
    
}
