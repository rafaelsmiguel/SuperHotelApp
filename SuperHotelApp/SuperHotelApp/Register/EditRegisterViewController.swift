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
    @IBOutlet weak var nacionalidadeTextField: UITextField!
    @IBOutlet weak var sexoTextField: UITextField!
    @IBOutlet weak var nascimentoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    let editDatePicker = UIDatePicker()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nomeTextField.delegate = self
        self.nacionalidadeTextField.delegate = self
        self.sexoTextField.delegate = self
        self.nascimentoTextField.delegate = self
        self.emailTextField.delegate = self
        self.senhaTextField.delegate = self
        
        createDatePicker()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveEditProfileButton () {
        
        print("save edit profile tapped")
    }

    @IBAction func cancelEditProfileButton () {
        
        print ("cancel edit profile tapped")
    }
    
    func createDatePicker () {
        let editToolBar = UIToolbar()
        editToolBar.sizeToFit()
        
        
        nascimentoTextField.inputAccessoryView = editToolBar
        nascimentoTextField.inputView = editDatePicker
        editDatePicker.preferredDatePickerStyle = .wheels
        
    }
    
}


extension EditRegisterViewController:UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
}
