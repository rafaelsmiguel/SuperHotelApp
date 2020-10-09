//
//  LoginViewController.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var welcoBackButton: UIButton!
    @IBOutlet weak var bigLoginLabel: UILabel!
    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var passLoginTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var alreadyNotLabel: UILabel!
    @IBOutlet weak var miniSignButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func welcoBackAction(_ sender: Any) {
        
        performSegue(withIdentifier: SegueType.backWelcoSegue.rawValue, sender: self)
        
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
    }
    
    @IBAction func miniSignAction(_ sender: Any) {
        
        performSegue(withIdentifier: SegueType.toRegisterFromLogin.rawValue, sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
