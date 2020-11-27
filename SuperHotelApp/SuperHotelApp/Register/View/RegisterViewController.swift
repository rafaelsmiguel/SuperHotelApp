//
//  RegisterViewController.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var backWelcomeButton: UIButton!
    @IBOutlet weak var bigSignLabel: UILabel!
    @IBOutlet weak var registerNameTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var alreadyLabel: UILabel!
    @IBOutlet weak var miniLoginButton: UIButton!
    
    var viewModel:RegisterViewModel = RegisterViewModel()
    
    var user:[User] = []

    var datePicker:UIDatePicker?
    
    override func viewDidLoad() {
        
        self.registerNameTextField.delegate = self
        self.fromTextField.delegate = self
        self.genreTextField.delegate = self
        self.emailTextField.delegate = self
        self.birthTextField.delegate = self
        self.passTextField.delegate = self
        self.confirmPassTextField.delegate = self
        
        datePicker = UIDatePicker()
        datePicker?.preferredDatePickerStyle = .wheels
        datePicker?.datePickerMode = .date
        birthTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(RegisterViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        
        
        
        super.viewDidLoad()
    }
    
    
    @IBAction func backWelcomeTapAction(_ sender: Any) {
        
        
        performSegue(withIdentifier: SegueType.backWelcomeSegue.rawValue, sender:self)
        
    }
    
    
    @objc func dateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.birthTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
    }
    
    
    
    @IBAction func signAction(_ sender: Any) {
      
        if passTextField.text == confirmPassTextField.text{
        
            viewModel.registerArray(
                name: self.registerNameTextField.text ?? "",
                from: self.fromTextField.text ?? "",
                genre: self.genreTextField.text ?? "",
                email: self.emailTextField.text ?? "",
                birth: self.birthTextField.text ?? "",
                password: self.passTextField.text ?? "",
                confirm: self.confirmPassTextField.text ?? "",
                array: &user)
            
            
            Auth.auth().signIn(withEmail: user[0].email, password: user[0].password) { (<#AuthDataResult?#>, <#Error?#>) in
                <#code#>
            }
            
            
            viewModel.printRegister(array: &user)
            viewModel.clearAllFields(name: self.registerNameTextField, from: self.fromTextField, genre: self.genreTextField, email: self.emailTextField, birth: self.birthTextField, password: self.passTextField, confirm: self.confirmPassTextField)
            
        }else{
            showToast(message: "Senhas não conferem",showTop: true)

        

    }
    }
    @IBAction func toLoginFromRegisterAction(_ sender: Any) {
       
        performSegue(withIdentifier: SegueType.toLoginfromRegister.rawValue, sender:self)
        
    }
}
    
extension RegisterViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case registerNameTextField:
            self.fromTextField.becomeFirstResponder()
        case fromTextField:
            self.emailTextField.becomeFirstResponder()
        case emailTextField:
            self.birthTextField.becomeFirstResponder()
        case birthTextField:
            self.passTextField.becomeFirstResponder()
        case passTextField:
            self.passTextField.resignFirstResponder()
            self.confirmPassTextField.placeholder = "Confirme sua senha!!"
        case confirmPassTextField:
            self.confirmPassTextField.resignFirstResponder()
            
        default:
        
            self.registerNameTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    
}

