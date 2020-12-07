//
//  RegisterViewController.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit
import Firebase


class RegisterViewController: BaseViewController {
    
    
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
        
        
        self.showLoading()
      
        if passTextField.text == confirmPassTextField.text{
        
            
            
            
            Auth.auth().createUser(withEmail: self.emailTextField.text ?? "", password: self.passTextField.text ?? "") { (result, error) in
                
                if error != nil {
                    
                    
                    self.hiddenLoading()
                    self.showToast(message: "Não foi possivel realizar o cadastro,cheque sua conexão,ou tente novamente mais tarde", showTop: true)
                }else{
                    
                    self.showToast(message: "Cadastro Realizado com Sucesso!", showTop: true)
                    self.hiddenLoading()
                }
            
            }
            
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

