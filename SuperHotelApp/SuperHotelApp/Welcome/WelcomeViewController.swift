//
//  WelcomeViewController.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var goLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    
    @IBAction func goSignUpAction(_ sender: Any) {
        
        performSegue(withIdentifier: SegueType.signSegue.rawValue, sender: self)
       
        
    }
    
    @IBAction func goLoginButton(_ sender: Any) {
        
        performSegue(withIdentifier: SegueType.loginSegue.rawValue, sender: self)
        
    }

}
