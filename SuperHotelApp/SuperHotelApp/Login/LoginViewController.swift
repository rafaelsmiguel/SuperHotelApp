//
//  LoginViewController.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    let controller:LoginController = LoginController()
    var loginArray:[User] = [User(name: "", from: "", genre: "", email: "", birth: "", password: "", confirm: "")]
    
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
        controller.isEnable(bool: false, button: loginButton)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func welcoBackAction(_ sender: Any) {
        
        performSegue(withIdentifier: SegueType.backWelcoSegue.rawValue, sender: self)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        
        if self.emailLoginTextField.text == loginArray[0].email && self.passLoginTextField.text == loginArray[0].password{
        
            controller.clearFields(fields: emailLoginTextField)
            controller.clearFields(fields: passLoginTextField)
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
                            let navigationViewController = storyBoard.instantiateViewController(withIdentifier: "MainNavigationController") as! MainNavigationController
                           navigationViewController.modalPresentationStyle = .fullScreen
                            self.present(navigationViewController, animated: true, completion: nil)
     
        
        print(self.loginArray.count)
    
        }else{
            
            showToast(message: "Conta Inexistente",showTop: true)
            controller.clearFields(fields: passLoginTextField)
        }
    }
    
    
    @IBAction func miniSignAction(_ sender: Any) {
        
        performSegue(withIdentifier: SegueType.toRegisterFromLogin.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            }
    
    
   
    
    

        
    
    // MARK: - Navigation

}

extension LoginViewController: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailLoginTextField{
            
            self.passLoginTextField.becomeFirstResponder()
        }else{
            self.passLoginTextField.resignFirstResponder()
            controller.isEnable(bool: true, button: loginButton)
        }
        return true
    }
    
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    }
    
    
    

