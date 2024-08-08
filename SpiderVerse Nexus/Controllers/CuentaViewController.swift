import UIKit
import FirebaseAuth

class CuentaViewController: UIViewController {

    @IBOutlet weak var updateInfoButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func updateInfoButtonTapped(_ sender: UIButton) {
        navigateToUpdateInfoScreen()
    }

    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
            navigateToLoginScreen()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            showAlert(title: "Error", message: "Hubo un error al cerrar sesión: \(signOutError.localizedDescription)")
        }
    }

    func navigateToUpdateInfoScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let updateInfoViewController = mainStoryboard.instantiateViewController(withIdentifier: "ActualizarInfoController") as? ActualizarInfoController {
            updateInfoViewController.modalPresentationStyle = .fullScreen
            self.present(updateInfoViewController, animated: true, completion: nil)
        }
    }

    func navigateToLoginScreen() {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        if let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            let navigationController = UINavigationController(rootViewController: loginViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        } else {
            print("LoginViewController no encontrado.")
        }
    }

    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
