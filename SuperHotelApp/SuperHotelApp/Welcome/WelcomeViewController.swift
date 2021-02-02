//
//  WelcomeViewController.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var goLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        
        self.logoImage.image = UIImage(named: "logo2")
        self.backgroundImage.image = UIImage(named: "projetowelco")
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
