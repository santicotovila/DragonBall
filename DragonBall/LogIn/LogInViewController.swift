//
//  LogInViewController.swift
//  DragonBall
//
//  Created by Santiago Coto Vila on 10/03/2025.
//

import UIKit

final class LogInViewController: UIViewController {
    
    static let identifier: String = String(describing: LogInViewController.self)
    
    
    
    //MARK: - Outlets
    
    @IBOutlet var BackgroundLogIn: UIImageView!
    
    @IBOutlet var MenuLogin: UIView!
    
    @IBOutlet var LabelEmail: UILabel!
    
    @IBOutlet var BoxEmail: UITextField!
    
    @IBOutlet var LabelPassword: UILabel!
    
    @IBOutlet var BoxPassword: UITextField!
    
    @IBOutlet var BoxContinue: UIButton!
    
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeItems()
       
        
    }
    
    @IBAction func LogInButtonTapped() {
        getLogin()
        
    }
        
        
        
        
private func getLogin() {
    let networkModel = NetworkModel.shared
        networkModel.login(
        user: "s@gmail.com",
        password: "Regularuser1") { result in
            switch result {
            case let .success(jwtToken):
                NetworkModel.shared.token = jwtToken
                
                DispatchQueue.main.async { [weak self] in
                    
                let heroesTableViewController = HeroesTableViewController()
                    self?.navigationController?.setViewControllers([heroesTableViewController], animated: true)
                
            }
                    
            case let .failure(error):
                print(error)
                    
                }
                
            }
                
                
                
        }
        
        
       
                
    }
            
        

private extension LogInViewController {
    
    func customizeItems() {
        
        MenuLogin.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        MenuLogin.layer.cornerRadius = 50
        LabelEmail.font = UIFont.boldSystemFont(ofSize: 22)
        BoxEmail.layer.cornerRadius = 15
        LabelPassword.font = UIFont.boldSystemFont(ofSize: 22)
        BoxPassword.layer.cornerRadius = 15
        BoxContinue.layer.cornerRadius = 50
        
    }
}
