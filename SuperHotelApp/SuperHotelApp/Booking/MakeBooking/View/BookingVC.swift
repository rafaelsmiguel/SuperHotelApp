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
    @IBOutlet weak var confirmButton: SHButton_FilledGreen!
    @IBOutlet weak var textFieldCheckin: UITextField!
    @IBOutlet weak var textFieldCheckout: UITextField!
    @IBOutlet weak var textFieldAdults: UITextField!
    
    private var pickerView: UIPickerView?
    private var datePicker: UIDatePicker!
    
    private var dateCheckin: Date?
    private var dateCheckout: Date?

    var bookingViewModel: BookingViewModel?
    
    var adults = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.bookingViewModel = BookingViewModel(hotel: HotelModel(destinationId: "", name: "", latitude: "", longitude: "", valueByNight: 0.0, address: "", images: []))
        
        self.hotelLabel.text = self.bookingViewModel?.hotelName
        self.setupTextField()
       
        self.setupPickerView()
        self.setupDatePicker()
        
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
    
    @IBAction func tapConfirmButton(_ sender: SHButton_FilledGreen) {
        
        if self.bookingViewModel?.checkIn == nil {
            showToast(message: "Check-in deve ser preenchido.")
            return
        }
        
        if self.bookingViewModel?.checkOut == nil {
            showToast(message: "Check-out deve ser preenchido.")
            return
        }
        
        if self.bookingViewModel?.checkInDate ?? Date() > self.bookingViewModel?.checkOutDate ?? Date(){
            showToast(message: "A data de check-in não pode ser após a data de check-out.")
            return
        }
        
        if self.bookingViewModel?.adults == nil || self.bookingViewModel?.adults == 0 {
            showToast(message: "Quantidade de hóspedes deve ser preenchido.")
            return
        }
        
        
//        let booking = BookingElement(hotelImage: "hotel1.jpg", hotelName: self.bookingViewModel?.hotelName, periodOfStay: self.bookingViewModel?.periodOfStay(), numberOfPeople: self.bookingViewModel?.adults, valueByNight: self.bookingViewModel?.valueByNightFormat, amount: self.bookingViewModel?.amount(), address: self.bookingViewModel?.address, latitude: "", longitude: "")
//
//        var aBooking: [BookingElement] = []
//
//        aBooking.append(booking)
        
        let refreshAlert = UIAlertController(title: "Reserva Efetuada", message: "Sua reserva foi efetuada com sucesso!", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Fechar", style: .default, handler: { (action: UIAlertAction!) in
            
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(aBooking) {
//              let defaults = UserDefaults.standard
//              defaults.set(encoded, forKey: "reservas")
//            }
            
            self.bookingViewModel?.fillInfoBooking()
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }))
        
        self.present(refreshAlert, animated: true)
        
    }
    
    //DatePicker
    
    private func setupDatePicker() {
        
        datePicker = UIDatePicker.init(frame: CGRect(x:0,y:0, width: self.view.bounds.width, height: 200))
        datePicker.datePickerMode = .date
//        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        self.textFieldCheckin.inputView = datePicker
        self.textFieldCheckout.inputView = datePicker
        
        let toolBar: UIToolbar = UIToolbar.init(frame: CGRect(x:0, y:0,width: self.view.bounds.width, height: 44))
        
        let spaceButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let confirmButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.confirmDate))
        
        let cancelButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(self.cancelDate))
        
        toolBar.setItems([cancelButton, spaceButton, confirmButton], animated: true)
        
        
        self.textFieldCheckin.inputAccessoryView = toolBar
        self.textFieldCheckout.inputAccessoryView = toolBar
        
    }
    
    @objc func confirmDate() {
        if textFieldCheckin.isFirstResponder {
            self.textFieldCheckin.text = self.bookingViewModel?.formatDate(date: self.datePicker.date)
            self.bookingViewModel?.setCheckin(checkIn: self.textFieldCheckin.text ?? "")
        } else {
            self.textFieldCheckout.text = self.bookingViewModel?.formatDate(date: self.datePicker.date)
            self.bookingViewModel?.setCheckout(checkOut: self.textFieldCheckout.text ?? "")
        }
        self.view.endEditing(true)
    }
    
    @objc func cancelDate() {
        self.textFieldCheckin.resignFirstResponder()
    }

}

extension BookingVC: UITextFieldDelegate {
    
    func setupTextField() {
        
        self.textFieldCheckin.delegate = self
        self.textFieldCheckout.delegate = self
        self.textFieldAdults.delegate = self
    }
}

extension BookingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    private func setupPickerView() {
        self.pickerView =  UIPickerView()
        self.pickerView?.delegate = self
        self.pickerView?.dataSource = self
        
        self.pickerView?.backgroundColor = .white
        self.pickerView?.setValue(UIColor.black, forKey: "textColor")
        self.textFieldAdults.inputView = self.pickerView
        
        self.adults = self.bookingViewModel?.maxAdultsForRoom() ?? []
        
        self.configToolBar()
    }
    
    
    private func configToolBar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.backgroundColor = UIColor.gray
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelAdults))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Selecionar", style: .plain, target: self, action: #selector(selectAdults))
        
        toolBar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.textFieldAdults.inputAccessoryView = toolBar
    }
    
    @objc private func cancelAdults() {
        self.textFieldAdults.resignFirstResponder()
    }
    
    @objc private func selectAdults() {
        
        let quantitySelected = self.pickerView?.selectedRow(inComponent: 0)
        
        self.textFieldAdults.text = "\(self.adults[quantitySelected ?? 0])"
        self.bookingViewModel?.setAdults(adults: self.adults[quantitySelected ?? 0])
        self.textFieldAdults.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return adults.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(adults[row])"
    }
}

