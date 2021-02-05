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
    
    var user:User?

    var datePicker:UIDatePicker?
    
    let genrePickerView = UIPickerView()
    
    var generos:[String] = ["Masculino","Feminino","Não Informar"]
    
    
    override func viewDidLoad() {
        
        self.registerNameTextField.delegate = self
        self.fromTextField.delegate = self
        self.genreTextField.delegate = self
        self.emailTextField.delegate = self
        self.birthTextField.delegate = self
        self.passTextField.delegate = self
        self.confirmPassTextField.delegate = self
        
//        date picker

        datePicker = UIDatePicker()
        datePicker?.preferredDatePickerStyle = .wheels
        datePicker?.datePickerMode = .date
        birthTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(RegisterViewController.dateChanged(datePicker:)), for: .valueChanged)
        
//        genre picker view
        
        self.genrePickerView.delegate = self
        self.genrePickerView.dataSource = self
        self.genreTextField.inputView = genrePickerView
        
        let toolBar: UIToolbar = UIToolbar.init(frame: CGRect(x:0, y:0,width: self.view.bounds.width, height: 44))
        
        let spaceButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let confirmButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.getGenre))
        
        let cancelButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(self.cancelGenre))
        
        toolBar.setItems([cancelButton, spaceButton, confirmButton], animated: true)
        
        
        self.genreTextField.inputAccessoryView = toolBar
        
        
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
    
    
    
    func saveInfoUserDefault() {
        
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()

            
            if let user = self.user {
                
                if let encoded = try? encoder.encode(user) {
                    defaults.set(encoded, forKey: "usuarioLogado")
                }
            }
        }
    
    
  @objc func getGenre(){
        
        self.emailTextField.becomeFirstResponder()
        
    }
    
    
    @objc func cancelGenre(){
        
        self.genreTextField.text = nil
        self.genreTextField.resignFirstResponder()
        
    }
        

    
    
    @IBAction func signAction(_ sender: Any) {
        
        
        self.showLoading()
      
        self.user = User(name: self.registerNameTextField.text ?? "", from: self.fromTextField.text ?? "", genre: self.genreTextField.text ?? "", email: self.emailTextField.text ?? "", birth: self.birthTextField.text ?? "", password: self.passTextField.text ?? "", confirm: self.confirmPassTextField.text ?? "")
        
       
        
        if passTextField.text == confirmPassTextField.text{
        
            
            
            
            Auth.auth().createUser(withEmail: self.emailTextField.text ?? "", password: self.passTextField.text ?? "") { (result, error) in
                
                if error != nil {
                    
                    
                    self.hiddenLoading()
                    self.showToast(message: "Não foi possivel realizar o cadastro,cheque sua conexão,ou tente novamente mais tarde", showTop: true)
                }else{
                    
                    self.saveInfoUserDefault()
                    self.hiddenLoading()
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
                    let navigationViewController = storyBoard.instantiateViewController(withIdentifier: "MainNavigationController") as! MainNavigationController
                    navigationViewController.modalPresentationStyle = .fullScreen
                    self.present(navigationViewController, animated: true, completion: nil)
                    
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
            self.genreTextField.becomeFirstResponder()
        case genreTextField:
            self.emailTextField.becomeFirstResponder()
        case emailTextField:
            self.birthTextField.becomeFirstResponder()
        case birthTextField:
            self.passTextField.becomeFirstResponder()
        case passTextField:
            self.confirmPassTextField.becomeFirstResponder()
        case confirmPassTextField:
            self.confirmPassTextField.resignFirstResponder()
            
        default:
        
            self.registerNameTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    
}




extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.generos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.generos[row]
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.genreTextField.text = self.generos[row]
    }
    
}
