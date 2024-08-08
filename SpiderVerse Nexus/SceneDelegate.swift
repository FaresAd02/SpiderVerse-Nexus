import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        
        var initialViewController: UIViewController
        
        // Verificar si el usuario ya ha iniciado sesión
        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController")
        } else {
            let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
            initialViewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
