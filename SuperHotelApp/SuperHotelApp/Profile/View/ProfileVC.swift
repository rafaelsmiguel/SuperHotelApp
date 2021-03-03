//
//  ProfileViewController.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var nacionalidadeLabel: UILabel!
    @IBOutlet weak var generoLabel: UILabel!
    @IBOutlet weak var nascimentoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var profileViewModel: ProfileViewModel?
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
        
        self.getLoggedUser()
    }
    
    func setupNavBar() {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = "Perfil"
    }
    
    @IBAction func editProfileButton () {
        print ("edit profile tapped")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let editRegisterVC = storyBoard.instantiateViewController(withIdentifier:"EditRegisterViewController") as! EditRegisterViewController
        editRegisterVC.editRegisterViewModel = EditRegisterViewModel(user: User(name: self.profileViewModel?.name ?? "", from: self.profileViewModel?.nationality ?? "", genre: self.profileViewModel?.genre ?? "", email: self.profileViewModel?.email ?? "", birth: self.profileViewModel?.birth ?? "", password: "", confirm: ""))
            
        editRegisterVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(editRegisterVC, animated: true)
    }
    
    @IBAction func exitButton () {
        print ("exit tapped")
        exitShowAlert()
    }
    
    func exitShowAlert() {
        let alert = UIAlertController(title: "Alerta", message: "Deseja realmente sair do aplicativo?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: {action in
           
        }))
        
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: {action in
            
            self.profileViewModel?.clearAllUserDefaults()
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationViewController = storyBoard.instantiateViewController(withIdentifier:"WelcomeViewController") as! WelcomeViewController
            navigationViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(navigationViewController, animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    func getLoggedUser(){
        self.profileViewModel = ProfileViewModel()
        self.profileViewModel?.getLoggedUser()
        self.fillFields()
    }
    
    func fillFields(){
        self.nomeLabel.text = self.profileViewModel?.name
        self.nacionalidadeLabel.text = self.profileViewModel?.nationality
        self.generoLabel.text = self.profileViewModel?.genre
        self.nascimentoLabel.text = self.profileViewModel?.birth
        self.emailLabel.text = self.profileViewModel?.email
    }
    
}
