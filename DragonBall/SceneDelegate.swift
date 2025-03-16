
import UIKit
 
 class SceneDelegate: UIResponder, UIWindowSceneDelegate {
     
     var window: UIWindow?
     
     
     func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
         guard let scene = (scene as? UIWindowScene) else { return }
         let window = UIWindow(windowScene: scene)
         
         //Configure first window
         
         let firstWindow = LogInViewController(nibName: LogInViewController.identifier, bundle: nil)
         
         let navigationController = UINavigationController(rootViewController: firstWindow)
         
         
         window.rootViewController = navigationController
         window.makeKeyAndVisible()
         self.window = window
         
         
        
         
         
     }
 }

