//
//  ProfileViewController.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ProfileVC: UIViewController {

   
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var nacionalidadeLabel: UILabel!
    @IBOutlet weak var generoLabel: UILabel!
    @IBOutlet weak var nascimentoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var senhaLabel: UILabel!
    
    
    
    var user:User?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
       
        self.getLoggedUser()
        
        
        /*self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 245.0/255.0, green: 246.0/255.0, blue: 247.0/255.0, alpha: 1.0)]*/
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    
    func setupNavBar() {
        let navigationBar = self.parent?.navigationItem
        navigationBar?.title = "Perfil"
    }
    
    

    @IBAction func editProfileButton () {
        print ("edit profile tapped")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let navigationViewController = storyBoard.instantiateViewController(withIdentifier:"EditRegisterViewController") as! EditRegisterViewController
        navigationViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(navigationViewController, animated: true)
        //navigationViewController.title = "Alterar Cadastro"
        
        
    }
    
    @IBAction func exitButton () {
        print ("exit tapped")
        exitShowAlert()
//        dismiss(animated: true, completion: nil)
    }
    
    func exitShowAlert() {
        let alert = UIAlertController(title: "Alerta", message: "Deseja realmente sair do aplicativo?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: {action in
            print("Não tapped")
        }))
        
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: {action in
            print("Sim tapped")
        }))
        
        present(alert, animated: true)
    }
    
    
//
//    func getUser(){
//
//        let user = Auth.auth().currentUser
//
//        if let user = user{
//
//            let uid = user.uid
//            let email = user.email
//            let photoURL = user.photoURL
//            
//            self.emailLabel.text = email
//
//        }
//
//    }
    
    
    func getLoggedUser(){
        
        let defaults = UserDefaults.standard
        
        if let user = defaults.object(forKey: "usuarioLogado") as? Data {
            let decoder = JSONDecoder()
            if let loadUser = try? decoder.decode(User.self, from: user){
                
                self.user = loadUser
                self.fillFields()
                
            }
        }
        
    }
    

    
    func fillFields(){
        
        
        
        self.nomeLabel.text = user?.name
        self.nacionalidadeLabel.text = user?.from
        self.generoLabel.text = user?.genre
        self.nascimentoLabel.text = user?.birth
        self.emailLabel.text = user?.email
        
    
}
    
}
