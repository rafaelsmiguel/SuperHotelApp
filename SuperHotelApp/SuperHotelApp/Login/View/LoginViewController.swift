//
//  LoginViewController.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: BaseViewController {
    
    
    
    let controller:LoginController = LoginController()
//    var user: User = User(name: "Teste", from: "Brasileiro", genre: "Masculino", email: "", birth: "02/05/1991", password: "", confirm: "")
    
    @IBOutlet weak var welcoBackButton: UIButton!
    @IBOutlet weak var bigLoginLabel: UILabel!
    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var passLoginTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var alreadyNotLabel: UILabel!
    @IBOutlet weak var miniSignButton: UIButton!
    
  

    override func viewDidLoad() {
        
        
        self.emailLoginTextField.delegate = self
        self.passLoginTextField.delegate = self
        self.isEnable(bool: false)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func welcoBackAction(_ sender: Any) {
        
        performSegue(withIdentifier: SegueType.backWelcoSegue.rawValue, sender: self)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        if (self.emailLoginTextField.text != nil) && self.passLoginTextField.text != ""{
            
            self.showLoading()
            
            Auth.auth().signIn(withEmail: self.emailLoginTextField.text ?? "", password: self.passLoginTextField.text ?? "") { (result, error) in
                
                if error != nil{
                    
                    self.hiddenLoading()
                    self.showToast(message: "Conta não cadastrada", showTop: true)
                    
                }else{
                    
//                    self.user.email = self.emailLoginTextField.text ?? ""
//                    self.user.password = self.emailLoginTextField.text ?? ""
//
//                    self.saveInfoUserDefault()
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
                    let navigationViewController = storyBoard.instantiateViewController(withIdentifier: "MainNavigationController") as! MainNavigationController
                    navigationViewController.modalPresentationStyle = .fullScreen
                    self.present(navigationViewController, animated: true, completion: nil)
                    
                    self.hiddenLoading()
                }
            }
            
        }else{
            
            self.showToast(message: "Preencha todos os campos", showTop: true)
            
        }
        
    }
    
    
//    func saveInfoUserDefault() {
//
//        let defaults = UserDefaults.standard
//        let encoder = JSONEncoder()
//
//        if let encoded = try? encoder.encode(user) {
//            defaults.set(encoded, forKey: "usuarioLogado")
//        }
//
//    }
    
    
    @IBAction func miniSignAction(_ sender: Any) {
        
        performSegue(withIdentifier: SegueType.toRegisterFromLogin.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }
    
    
    func clearFields(){
        
        self.emailLoginTextField.text = nil
        self.passLoginTextField.text = nil
    }
    
    func isEnable(bool:Bool){
        
        if bool == true{
            
            self.loginButton.isEnabled = true
        }else{
            
            self.loginButton.isEnabled = false
            
        }
    
    // MARK: - Navigation
}
}

extension LoginViewController: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailLoginTextField{
            
            self.passLoginTextField.becomeFirstResponder()
        }else{
            self.passLoginTextField.resignFirstResponder()
            self.isEnable(bool: true)
        }
        return true
    }
    }
    
    
    

