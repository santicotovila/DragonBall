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

    @IBOutlet var BackgroundLogin: UIImageView!
    
    @IBOutlet var EmailLabel: UITextField!
    
    @IBOutlet var PasswordLabel: UITextField!
    
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeItems()
       
        
    }
    
    @IBAction func LogInButtonTapped() {
        getLogin()
    }
    
    //He tenido que crear esta función porque quería dejar como rpivada la de getLogin y para asi hacer las pruebas del login a red.

func performLogin(user: String, password: String, completion: @escaping (Result<String, APIClientError>) -> Void) {
        let networkModel = NetworkModel.shared
        networkModel.login(user: user, password: password, completion: completion)
        }
        
    private func getLogin() {
    
    guard let user = EmailLabel.text, !user.isEmpty,
            let password = PasswordLabel.text, !password.isEmpty else {return}
    
    
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
        
        BackgroundLogin.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(BackgroundLogin, at: 0)

        NSLayoutConstraint.activate([
            BackgroundLogin.topAnchor.constraint(equalTo: view.topAnchor),
            BackgroundLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            BackgroundLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            BackgroundLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        
    }
}
