//
//  EditRegisterViewController.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit

class EditRegisterViewController: UIViewController {
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var nacionalidadeTextField: SHTextFieldCenter!
    @IBOutlet weak var sexoTextField: SHTextFieldCenter!
    @IBOutlet weak var nascimentoTextField: SHTextFieldCenter!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var pickerViewGenre: UIPickerView?
    private var pickerViewNationality: UIPickerView?
    private var datePicker: UIDatePicker!
    
    var editRegisterViewModel: EditRegisterViewModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextField()
        self.setupGenrePickerView()
        self.setupNationalityPickerView()
        self.setupDatePicker()
        self.fillFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = "Cadastro"
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveEditProfileButton () {
        
        self.editRegisterViewModel?.setName(name: nomeTextField.text ?? "")
        self.editRegisterViewModel?.setEmail(email: emailTextField.text ?? "")
        
        let message = editRegisterViewModel?.verifyEmptyFields()
        
        if message == "" {
            self.editRegisterViewModel?.saveInfoUserDefault()
            self.showToast(message: "Dados alterados com sucesso.")
        } else {
            self.showToast(message: message ?? "")
        }
    }

    @IBAction func cancelEditProfileButton () {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fillFields() {
        self.nomeTextField.text = self.editRegisterViewModel?.name
        self.nacionalidadeTextField.text = self.editRegisterViewModel?.nationality
        self.sexoTextField.text = self.editRegisterViewModel?.genre
        self.nascimentoTextField.text = self.editRegisterViewModel?.birth
        self.emailTextField.text = self.editRegisterViewModel?.email
    }
    
    private func setupDatePicker() {
        
        datePicker = UIDatePicker.init(frame: CGRect(x:0,y:0, width: self.view.bounds.width, height: 200))
        datePicker.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        self.nascimentoTextField.inputView = datePicker
        
        let toolBar: UIToolbar = UIToolbar.init(frame: CGRect(x:0, y:0,width: self.view.bounds.width, height: 44))
        
        let spaceButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let confirmButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.confirmDate))
        
        let cancelButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(self.cancelDate))
        
        toolBar.setItems([cancelButton, spaceButton, confirmButton], animated: true)
        
        self.nascimentoTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func confirmDate() {
        
        self.nascimentoTextField.text = self.editRegisterViewModel?.formatDate(date: self.datePicker.date)
        self.editRegisterViewModel?.setBirth(birth: self.nascimentoTextField.text ?? "")

        self.view.endEditing(true)
    }
    
    @objc func cancelDate() {
        self.nascimentoTextField.resignFirstResponder()
    }
}

extension EditRegisterViewController: UITextFieldDelegate {
    
    func setupTextField() {
        self.nacionalidadeTextField.delegate = self
        self.sexoTextField.delegate = self
        self.nascimentoTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
}

extension EditRegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    private func setupGenrePickerView() {
        self.pickerViewGenre =  UIPickerView()
        self.pickerViewGenre?.delegate = self
        self.pickerViewGenre?.dataSource = self
        self.pickerViewGenre?.tag = 1
        
        self.pickerViewGenre?.backgroundColor = .white
        self.pickerViewGenre?.setValue(UIColor.black, forKey: "textColor")
        self.sexoTextField.inputView = self.pickerViewGenre
        
        self.configToolBar(tag: 1)
    }
    
    private func setupNationalityPickerView() {
        self.pickerViewNationality =  UIPickerView()
        self.pickerViewNationality?.delegate = self
        self.pickerViewNationality?.dataSource = self
        self.pickerViewNationality?.tag = 2
        
        self.pickerViewNationality?.backgroundColor = .white
        self.pickerViewNationality?.setValue(UIColor.black, forKey: "textColor")
        self.nacionalidadeTextField.inputView = self.pickerViewNationality
        
        self.configToolBar(tag: 2)
    }
    
    
    private func configToolBar(tag: Int) {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.backgroundColor = UIColor.gray
        toolBar.sizeToFit()
        
        if tag == 1 {
            let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelGenre))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Selecionar", style: .plain, target: self, action: #selector(selectGenre))
            
            toolBar.setItems([cancelButton,spaceButton,doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            self.sexoTextField.inputAccessoryView = toolBar
        } else {
            let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelNationality))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Selecionar", style: .plain, target: self, action: #selector(selectNationality))
            
            toolBar.setItems([cancelButton,spaceButton,doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            self.nacionalidadeTextField.inputAccessoryView = toolBar
        }
    }
    
    @objc private func cancelGenre() {
        self.sexoTextField.resignFirstResponder()
    }
    
    @objc private func selectGenre() {
        
        let index = self.pickerViewGenre?.selectedRow(inComponent: 0)
        
        self.sexoTextField.text = "\(Mocks.genre[index ?? 0])"
        self.editRegisterViewModel?.setGenre(genre: Mocks.genre[index ?? 0])
        self.sexoTextField.resignFirstResponder()
    }
    
    @objc private func cancelNationality() {
        self.nacionalidadeTextField.resignFirstResponder()
    }
    
    @objc private func selectNationality() {
        
        let index = self.pickerViewNationality?.selectedRow(inComponent: 0)
        
        self.nacionalidadeTextField.text = "\(Mocks.nationality[index ?? 0])"
        self.editRegisterViewModel?.setNationality(nationality: Mocks.nationality[index ?? 0])
        self.nacionalidadeTextField.resignFirstResponder()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return Mocks.genre.count
        } else {
            return Mocks.nationality.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return "\(Mocks.genre[row])"
        } else {
            return "\(Mocks.nationality[row])"
        }
    }
}
