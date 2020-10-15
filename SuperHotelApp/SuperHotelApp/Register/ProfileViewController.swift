//
//  ProfileViewController.swift
//  SuperHotel
//
//  Created by Rafael Miguel on 21/09/20.
//  Copyright © 2020 Rafael Miguel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileArray: [Profile] = [Profile(nome: "Elder Alcantara", nacionalidade: "Brasileira", sexo: "Masculino", nascimento: "25/05/1983", email: "elder@alcantara.com", senha: "123456")]
    
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var nacionalidadeLabel: UILabel!
    @IBOutlet weak var sexoLabel: UILabel!
    @IBOutlet weak var nascimentoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var senhaLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeLabel?.text = profileArray[0].nome
        nacionalidadeLabel?.text = profileArray[0].nacionalidade
        sexoLabel?.text = profileArray[0].sexo
        nascimentoLabel?.text = profileArray[0].nascimento
        emailLabel?.text = profileArray[0].email
        senhaLabel?.text = profileArray[0].senha
        
        
        
        /*self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 245.0/255.0, green: 246.0/255.0, blue: 247.0/255.0, alpha: 1.0)]*/
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func editProfileButton () {
        print ("edit profile tapped")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let navigationViewController = storyBoard.instantiateViewController(withIdentifier:"EditRegisterViewController") as! EditRegisterViewController
        navigationViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(navigationViewController, animated: true)
        //navigationViewController.title = "Alterar Cadastro"
        

                //        self.navigationController?.pushViewController(searchViewController, animated: true)
//                        navigationViewController.modalPresentationS
        
        
    }
    
    @IBAction func exitButton () {
        print ("exit tapped")
        exitShowAlert()
        
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

}
